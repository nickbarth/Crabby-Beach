using UnityEngine;

public class PlayerController : MonoBehaviour {
    
    public float Speed = 3f;
    
    private Vector3 _movement;
    private Rigidbody _playerRigidBody;
    
    private void Awake()
    {
        _playerRigidBody = GetComponent<Rigidbody>();
    }
    
    
    private void FixedUpdate()
    {
        float  horizontal  = Input.GetAxisRaw("Horizontal");
        float vertical  = Input.GetAxisRaw("Vertical");
        
        Move(horizontal, vertical);
    }
    
    private void Move(float horizontal, float vertical)
    {
        _movement = (vertical * transform.forward) + (horizontal * transform.right);
        _movement = _movement.normalized * Speed * Time.deltaTime;
        _playerRigidBody.MovePosition(transform.position + _movement);
    }
}


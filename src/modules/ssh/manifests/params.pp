class ssh::params {
  $root_keys = {
    'ishishkin' => {
       type => 'ssh-dss',
       key => 'AAAAB3NzaC1kc3MAAACBAJ3VUY9d9X6SBlqM0/OvqyTIY5oK26eycfkJV7a1FhPOYJ15TlwcTNrs/i48/F9aUQZ9mmUIeFQYyAJ+2WII17t2d5aEVV9vs49mnB8VbfKMa92JkXrfUOvo7hGAQUZ7+UOt9tcBhDTqQUleLmRHYCZqWPeIy0IvRCVmGbjKQN4zAAAAFQC/pm7T0h6gN1xU3UHjds1/en+vOQAAAIA9unK2Q3VpVk5zF90eGSD9mLM4ni93GFjsN+1/kwCRBNidilZZJCQ7bLD22SxgttxUsTItjmD2cQXLyoSsxWQeiEy3aNLbkESNAz+97ORpZZgVxhTZ+sMfxsQlIcwWwXgLlkH90A9CDkfWWNXBAp4eg4OjBnhxhbnNDLoJdgrxZQAAAIBaWI6pFXMMsWS9zNPOzrg+XT2QR4+0QxwpaOfzazJz4JPYp10xYZb7NCW6gNPM9kzwdYcf3CnZlwy89ZR1oQUEtCpPBKqyVZD6VBBzI+GiTnzB/y/r0kchEDiap38nSCMdAaQ2MpJmwt8MgeN5uF+BnqjzyN0PaKGfa35s/9jaZg==', 
     },
     'afedorova' => {
       type => 'ssh-rsa',
       key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDKgCCELnGto4MROegcB3i68q+j0fTZYNHEWLKx6yYhi1G/xB6sPqhvY14/3unAr0isF2pYEEV2HgG0zUGBCKyaCV9Py9+6Zb1HVAjvw8+6MA2B4dHZr46n+jZmn5c/rNRggaC6mEYEu4RoUefrbyLs7hdxSrQpeyBk3F8GC/4mXBQP4vxXkzkbEn2fLVGCfevip3dLRRt6QoP5dEvyhm3b0s1dlTGQ554Gw3g3gZHBuVqCIk4nc4P0Bz5bn7v93+PLih6S9SdM3RFbIl+KBz1byOqLMQPXH0dwZ0lVsG3PePfnykc9OVNClx4T6JEoxYWECCfHZZULln9gHsGy3PzJ',
    }
  }
  $service = 'ssh'
  $sshd_config = '/etc/ssh/sshd_config'
}

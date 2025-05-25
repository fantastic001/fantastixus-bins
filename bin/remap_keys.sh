#!/bin/bash

/usr/bin/hidutil property --set '{
  "UserKeyMapping": [
    {
      "HIDKeyboardModifierMappingSrc": 0x700000064,
      "HIDKeyboardModifierMappingDst": 0x700000035
    },
    {
      "HIDKeyboardModifierMappingSrc": 0x700000058,
      "HIDKeyboardModifierMappingDst": 0x700000031
    }
  ]
}'

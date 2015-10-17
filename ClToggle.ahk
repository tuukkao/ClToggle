;ClToggle
;(C) 2013-2015 Tuukka Ojala <tuukka.ojala@gmail.com>

#NoTrayIcon
#SingleInstance Ignore

;The delay in milliseconds for registering a window.
register_delay := 200

CapsLock::
    begin_time := A_TickCount
    while true {
        getKeyState capslock_state, CapsLock, P
        if (A_TickCount -begin_time > register_delay) and capslock_state == "D" and not activated {
            activated := true
            goto assign_window
        } else if activated and capslock_state == "U" {
            ;Do nothing until caps lock has been released
            break
        } else if not activated and (capslock_state == "U") {
            ;Switch between windows
            goto switch_window
        }
    }
    activated := false
return

assign_window:
    winGet memory_window, ID, A
    soundPlay assigned.wav, 1
return

switch_window:
    winGet current_window, ID, A
    if (current_window <> memory_window) {
        previous_window := current_window
        winActivate ahk_id %memory_window%
    } else {
        winActivate ahk_id %previous_window%
    }
return
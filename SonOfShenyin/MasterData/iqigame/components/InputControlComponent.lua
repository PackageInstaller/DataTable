-- chunkname: @IQIGame\\Components\\InputControlComponent.lua

local InputControlComponent = Base:Extend("InputControlComponent", "IQIGame.Onigao.Components.InputControlComponent", {})

function InputControlComponent:InitInput()
	return
end

function InputControlComponent:Awake()
	return
end

function InputControlComponent:OnEnable()
	return
end

function InputControlComponent:Start()
	local inputComponent = GameEntry.Input

	inputComponent:InitTapGesture()
	inputComponent:InitRotateGesture()

	local tapGesture = inputComponent.TapGesture

	tapGesture.Updated = tapGesture.Updated + InputControlComponent.OnTapGesture
end

function InputControlComponent.OnTapGesture(gesture, touches)
	Log.Info("OnTapGesture")

	if gesture.State ~= DigitalRubyShared.GestureRecognizerState.Ended then
		return
	end

	local ray = UnityEngine.Camera.main:ScreenPointToRay(Vector3(gesture.FocusX, gesture.FocusY, 0))
	local isHit, hit = UnityEngine.Physics.Raycast(ray, hit)

	if isHit then
		Log.Info("Hit the Gameobject :" .. hit.collider.gameObject.name)
	end
end

function InputControlComponent.OnRotateGesture(gesture, touches)
	Log.Info("OnRotateGesture")
end

function InputControlComponent:Update()
	return
end

function InputControlComponent:FixedUpdate()
	return
end

function InputControlComponent:LateUpdate()
	return
end

function InputControlComponent:OnBecameVisible()
	return
end

function InputControlComponent:OnBecameInvisible()
	return
end

function InputControlComponent:OnDisable()
	return
end

function InputControlComponent:OnDestroy()
	return
end

return InputControlComponent

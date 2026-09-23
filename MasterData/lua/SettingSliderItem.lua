local keyName = ""
local lastNum = 0
local lastState = 0 --左为-1右为1
local isSlider = false
local sliderTime = 200
function Awake()
	sliderMusice = ComUtil.GetCom(slider, "Slider")
end

function OnEnable()
	--CSAPI.AddToggleCallBack(Toggle, ToggleCB)
	CSAPI.AddSliderCallBack(slider, SliderCB)
	
	transform.offsetMin = UnityEngine.Vector2(0, 0)
	transform.offsetMax = UnityEngine.Vector2(0, 0)
end

function OnDisable()
	--CSAPI.RemoveToggleCallBack(Toggle, ToggleCB)
	CSAPI.RemoveSliderCallBack(slider, SliderCB)
end

function Update()
	if sliderTime > 0 then
		sliderTime = sliderTime - Time.fixedDeltaTime
	elseif sliderTime <= 0 and isSlider then
		CSAPI.StopUISound("ui_infolineeject_in")
		CSAPI.StopUISound("ui_infolineeject_out")
		lastState = 0
		isSlider = false
	end
end

function Init(_key)
	isInit = false
	key = _key	
	CSAPI.SetRTSize(sliderObj,1006,44)
	-- CSAPI.SetRTSize(bg,1462,208)	
	if(key == s_audio_scale.music) then		
		titleStr = LanguageMgr:GetByID(14016)
		--switchKey = s_switch_key.music
		valueKey = s_audio_scale.music
		keyName = s_music_cache_key
		CSAPI.SetRTSize(sliderObj,935,44)
	elseif(key == s_audio_scale.sound) then
		titleStr = LanguageMgr:GetByID(14017)
		--switchKey = s_switch_key.sound
		valueKey = s_audio_scale.sound
		keyName = "14017"
		CSAPI.SetRTSize(sliderObj,935,44)
	elseif(key == s_audio_scale.dubbing) then
		titleStr = LanguageMgr:GetByID(14018)
		--switchKey = s_switch_key.dubbing
		valueKey = s_audio_scale.dubbing
		keyName = "14018"
		CSAPI.SetRTSize(sliderObj,935,44)
	elseif(key == s_screen_scale_key) then
		titleStr = LanguageMgr:GetByID(14019)
		--switchKey = s_switch_key.dubbing
		valueKey = s_screen_scale_key
		CSAPI.SetRTSize(sliderObj,1133,44)
		-- CSAPI.SetRTSize(bg,1462,172)		
	end
	SetTitle()
	Refresh()
	isInit = true	
end

function Refresh()
	--SetSwaich()
	SetScale()
	SetSound()
end

function SetTitle()
	CSAPI.SetText(txt1, titleStr)
end

function SetSound()
	CSAPI.SetGOActive(btnSound, valueKey ~= s_screen_scale_key)
	local _value = SettingMgr:GetValue(valueKey)
	CSAPI.SetGOActive(soundClose, _value <= 0)
	CSAPI.SetGOActive(soundOpen, _value > 0)
end

-- function SetSwaich()
-- 	local switch = SettingMgr:GetValue(switchKey)
-- 	CSAPI.SetToggle(Toggle, switch == 1)
-- 	CSAPI.SetGOActive(sliderMask, switch == 2)
-- end
function SetScale()
	--local switch = SettingMgr:GetValue(switchKey)
	local _value = SettingMgr:GetValue(valueKey)
	--local value = switch == 1 and _value or 0
	--CSAPI.SetSlider(slider, _value / 100)
	sliderMusice.value = _value / 100
	lastNum = sliderMusice.value
	if(key == s_screen_scale_key) then
		CSAPI.SetText(txt2, math.floor(_value) .. "")
	else
		CSAPI.SetText(txt2, math.floor(_value) .. "")
	end
end

-- function ToggleCB(b)
-- 	if(isInit == false) then
-- 		return
-- 	end
-- 	local num = b and 1 or 2
-- 	SettingMgr:SaveValue(switchKey, num, true)
-- 	SettingMgr:SetAudioScale(switchKey)
-- 	Refresh()
-- end
function SliderCB(_num)
	CSAPI.SetGOActive(soundClose, _num <= 0)
	CSAPI.SetGOActive(soundOpen, _num > 0)
	if(isInit == false) then
		return
	end
	sliderTime = 0.1
	isSlider = true
	--local switch = SettingMgr:GetValue(switchKey)
	--if(switch == 1) then
	local num,num2 = math.modf(_num * 100)
	if num2 > 0.5 then
		num = num + 1
	end
	SettingMgr:SaveValue(valueKey, num)
	if(key == s_screen_scale_key) then
		SettingMgr:SetScreenScale(num)
		CSAPI.SetText(txt2, num .. "")
	else
		SettingMgr:SetAudioScale(valueKey, num)
		CSAPI.SetText(txt2, num .. "")
	end	
	--end
	local state = _num - lastNum > 0 and 1 or - 1
	
	
	if _num <= 0 or _num >= 1 then
		CSAPI.PlayUISound("ui_hints_error");
	elseif _num - lastNum > 0 and lastState ~= 1 then
		CSAPI.StopUISound("ui_infolineeject_in")
		CSAPI.PlayUISound("ui_infolineeject_out")
	elseif _num - lastNum < 0 and lastState ~= - 1 then
		CSAPI.StopUISound("ui_infolineeject_out")
		CSAPI.PlayUISound("ui_infolineeject_in")
	end
	lastState = state
	lastNum = _num
end


function OnClickL()
	local _value = SettingMgr:GetValue(valueKey)
	if(_value > 0) then
		local start = _value
		_value = _value - 1
		sliderMusice.value = _value / 100
		-- SettingMgr:SaveValue(valueKey, _value)
	end
end

function OnClickR()
	local _value = SettingMgr:GetValue(valueKey)
	if(_value < 100) then
		local start = _value
		_value = _value + 1
		sliderMusice.value = _value / 100
		-- SettingMgr:SaveValue(valueKey, _value)
	end
end

function OnClickSound()	
	local _value = SettingMgr:GetValue(valueKey)
	--LogError(keyName)
	if(_value > 0) then
		PlayerPrefs.SetInt(keyName, _value)
		_value = 0
	else
		_value = PlayerPrefs.GetInt(keyName) > 0 and PlayerPrefs.GetInt(keyName) or 50
	end
	sliderMusice.value = _value / 100
	-- SettingMgr:SaveValue(valueKey, _value)
end 
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
txt1=nil;
slider=nil;
txt2=nil;
btnSound=nil;
soundClose=nil;
soundOpen=nil;
view=nil;
end
----#End#----
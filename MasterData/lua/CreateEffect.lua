
local isClick = false

function Awake()
	CSAPI.SetGOActive(point, false)
end

function SetClickCB(_cb)
	cb = _cb
end

function Refresh(_index, _quality, pos, is10)
	index = _index
	quality = _quality
	local res = is10 and "OpenBox/small_Blue" or "OpenBox/Large_Blue"
	if(quality == 6) then
		res = is10 and "OpenBox/small_Color" or "OpenBox/Large_Color"
	elseif(quality == 5) then
		res = is10 and "OpenBox/small_Gold" or "OpenBox/Large_Gold"
	elseif(quality == 4) then
		res = is10 and "OpenBox/small_Purple" or "OpenBox/Large_Purple"
	end
	ResUtil:CreateEffect(res, 0, 0, 0, point)
	CSAPI.SetAnchor(gameObject, pos[1], pos[2], pos[3])
	
	--light
	if(is10) then
		CSAPI.SetScale(light, 1, 1, 1)
		CSAPI.SetAnchor(light, - 5, 40, 0)
	else
		CSAPI.SetScale(light, 1.5, 1.5, 1)
		CSAPI.SetAnchor(light, 0, 58, 0)
	end
	local aim = ComUtil.GetCom(light, "ActionBase")
	local delay = 500
	if(index > 3) then
		delay = index > 7 and 800 or 650
	end
	aim.delay = delay
	aim:ToPlay()
end

function OnClick()
	if(not isClick) then
		isClick = true
		CSAPI.SetGOActive(point, true)
		cb(index)
		--		if(quality >= 5) then
		--			CSAPI.Vibrate2(1) --振动
		--		end
		--CSAPI.SetGOActive(light, false)
		CSAPI.SetGOActive(animLight2, true)
		
		if(quality >= 5) then
			CSAPI.PlayUICardSound("ui_core_golden")	
		elseif(quality >= 4) then
			CSAPI.PlayUICardSound("ui_core_purple")	
		else
			CSAPI.PlayUICardSound("ui_core_bule")	
		end
	end
end

function OnEnterClick()
	OnClick()
end

function OnDownClick()
	OnClick()
end
function OnDestroy()	
	ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	btnEffect = nil;
	point = nil;
	light = nil;
	animLight1 = nil;
	animLight2 = nil;
	view = nil;
end
----#End#----

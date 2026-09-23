
local grid = nil;
local fade = nil
function Awake()
	hpImg = ComUtil.GetCom(hp, "Image")
	hotImg = ComUtil.GetCom(hot, "Image")	
	canvasGroup = ComUtil.GetCom(node, "CanvasGroup")	
	
	CSAPI.SetGOActive(node, false)
	
	fade = ComUtil.GetCom(node, "ActionFade")
	fade.time = 250
end

function OnDisable()
	CSAPI.SetGOActive(node, false)
	isFirst = false
end

function InitPanel()
	CSAPI.SetGOActive(nilImg, true)
	CSAPI.SetGOActive(icon, false)
	SetState()
	CSAPI.SetText(txtLv, "----")
	CSAPI.SetGOActive(txt_death, false)
	hpImg.fillAmount = 0
	hotImg.fillAmount = 0
end

function Refresh(teamItemData, elseData)
	InitPanel()
	this.teamItemData = teamItemData;
	if teamItemData then	
		CSAPI.SetGOActive(nilImg, false)
		if teamItemData:GetIcon() then
			CSAPI.SetGOActive(icon, true)
			ResUtil.RoleCard:Load(icon, teamItemData:GetIcon() .. "", true)
			if idx == 1 then
				-- SetState(1)
			elseif idx == 6 and teamItemData.bIsNpc then
				SetState(2)
			end
		end		
	end	
	-- SetFade()
end

function SetClickCB(cb)
	this.cb = cb
end

function SetClick(isClick)
	CSAPI.SetGOActive(mask, isClick)
	--grid.ActiveClick(isClick);
end

function SetDeath(isDeath)
	-- canvasGroup.alpha = isDeath and 0.3 or 1
	if isDeath then
		CSAPI.SetText(txtLv, "")
		-- CSAPI.SetGOActive(txt_death, true)
	end
end

function SetHot(currHot, totalHot)
	hotImg.fillAmount = currHot / totalHot
end

function SetHP(percent)
	if percent then
		hpImg.fillAmount = percent;
	end
end

function SetSP(percent)
	if percent then
		hotImg.fillAmount = percent;
	end
end

function SetIndex(num)
	idx = num
	if num then
		-- local isShow = num < 6;
		-- CSAPI.SetGOActive(hot, isShow);
		fade.delay = 200 +(idx - 1) * 70
	end
end

function SetLv(lv)
	local lvStr = LanguageMgr:GetByID(1033) or "LV."
	CSAPI.SetText(txtLv, lvStr .. lv)
end

function OnClick()
	if this.cb then
		--CSAPI.PlayUISound("ui_generic_click")
		this.cb(this);
	end
end

function SetNil(isNil)
	CSAPI.SetGOActive(root, not isNil)
	CSAPI.SetGOActive(nilImg, isNil)
end

--头衔
function SetState(_num)
	if _num and _num > 0 then
		CSAPI.SetGOActive(state, true)
		local color = _num == 1 and {255, 205, 106} or {255, 255, 255}
		CSAPI.SetImgColor(state, color[1], color[2], color[3], 255)
		local str = StringUtil:SetByColor(_num == 1 and "CAPTAIN" or "SUPPORT", _num == 1 and "000000" or "929296")
		CSAPI.SetText(txtState, str)
	else
		CSAPI.SetGOActive(state, false)
	end
end

function SetFade()
	local alpha = 1
	if not this.teamItemData or hpImg.fillAmount <= 0 then
		alpha = 0.3
	end
	if(not isFirst) then		
		fade.to = alpha
		CSAPI.SetGOActive(node, true)
		isFirst = true
	else
		canvasGroup.alpha = alpha
	end
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
	node = nil;
	icon = nil;
	hpObj = nil;
	hp = nil;
	hotObj = nil;
	hot = nil;
	txtLv = nil;
	state = nil;
	txtState = nil;
	txt_death = nil;
	nilImg = nil;
	mask = nil;
	view = nil;
end
----#End#----

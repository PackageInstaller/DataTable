function Awake()
	--btn = ComUtil.GetCom(icon, "Button")
end

function SetIndex(_index)
	index = _index
end

function SetClickCB(_cb)
	cb = _cb
end

function OnRecycle()
	cb = nil
	cardData = nil
	elseData = nil
	ActiveClick(true)
end

function Refresh(_cardData, _elseData)
	CSAPI.SetGOActive(gameObject, true)
	
	cardData = _cardData
	elseData = _elseData
	
	CSAPI.SetGOActive(icon, cardData ~= nil)
	CSAPI.SetGOActive(empty, cardData == nil)
	SetGray(false);
	if(cardData) then
		SetEntity()
	end
end

function SetEntity()
	if(cardData) then
		SetIcon(cardData:GetSmallImg())
		SetBgIcon(cardData:GetQuality())
		SetLv(cardData:GetLv())
	end

end


function SetGray(isGray)
	local color = isGray and {89, 89, 89, 255} or {255, 255, 255, 255};
	CSAPI.SetTextColor(icon, color[1], color[2], color[3], color[4], true);
	CSAPI.SetImgColor(icon, color[1], color[2], color[3], color[4], true);
end

--icon
function SetIcon(_iconName)
	if(_iconName) then
		ResUtil.RoleCard:Load(icon, _iconName)
	end
end

--bgicon
function SetBgIcon(_quality)
	CSAPI.LoadImg(bgIcon, "UIs/RoleTeamCard/" .. _quality .. "a.png", true, nil, true)
end

--等级
function SetLv(_lv)
	_lv = _lv or 1
	if _lv then
		CSAPI.SetText(txtLv2, tostring(_lv))
	end
end

--是否可按 默认开启
function ActiveClick(_b)
	CSAPI.SetGOActive(btnClick, _b)
end

function OnClick()
	if(cb) then
		cb(this)
	end
end

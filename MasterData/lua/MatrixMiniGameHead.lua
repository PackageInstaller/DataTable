
local moveTimer = 1000

function Refresh(_index, _cardData, _moveCB)
	index = _index
	cardData = _cardData
	moveCB = _moveCB
	
	--icon
	SetIcon()
	--
	SetNext()
	--
	CSAPI.SetGOActive(enterAction, true)
end

--放到炮弹上
function Refresh2(_cardData)
	index = 0
	cardData = _cardData
	SetIcon()
	SetNext()
end

function SetIcon()
	local cfg = cardData:GetModelCfg()
	ResUtil.RoleCard:Load(icon, cfg.icon)
end

function SetNext()
	CSAPI.SetGOActive(next, index == 1)
end


--移动到下一个位置
function MoveNext(x2, y2)
	index = index - 1
	local x1, y1 = CSAPI.SetAnchor(gameObject)
	UIUtil:SetPObjMove(scaleNode, x1, x2, y1, y2, 0, 0, nil, moveTimer)
	if(index == 1) then
		UIUtil:SetObjScale(scaleNode, 0.6, 1, 0.6, 1, 1, 1, moveCB, moveTimer)
	end
end


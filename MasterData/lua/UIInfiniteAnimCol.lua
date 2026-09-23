--向左缩进 冷却系统
local this = {}

local animTotalTime = 1.5 --动画总时长

function this.New()
	this.__index = this.__index or this
	local ins = {}
	setmetatable(ins, this)
	return ins
end


function this:InitData(_layout)
	self.layout = _layout
	self.layout.animTotalTime = animTotalTime
end

function this:AnimPlay()
	if(not self.layout) then
		return
	end
	-- local indexs = self.layout:GetIndexs()
	-- local len = indexs.Length
	-- local delay =(animTotalTime / len * 1000) - 500
	-- local arr = CSAPI.GetScreenSize()
	-- local perSizeArr = self.layout:GetPerSize()
	-- for i = 0, len - 1 do
	-- 	local index = indexs[i]
	-- 	local lua = self.layout:GetItemLua(index)
	-- 	if(lua and lua.gameObject) then
	-- 		local posArr = self.layout:GetInfoPos(index)
	-- 		CSAPI.SetLocalPos(lua.gameObject, arr[0] + perSizeArr[0] * i, posArr[1], 0)
	-- 		CSAPI.MoveToByTime2(lua.gameObject, "action_move_by_curve", arr[0] + perSizeArr[0] * i, posArr[1], 0, posArr[0], posArr[1], 0, nil, 500 + i * 30, delay * i)
	-- 	end
	-- end
	--进场动画 800ms开始 
	local indexs = self.layout:GetIndexs()
	local len = indexs.Length
	for i = 0, len - 1 do
		local index = indexs[i]
		local lua = self.layout:GetItemLua(index)
		if(lua and lua.gameObject) then
			local canvasGroup = ComUtil.GetCom(lua.gameObject, "CanvasGroup")
			canvasGroup.alpha = 0
			local delay = 500 +(index - 1) * 100
			local timer = 800
			--all
			UIUtil:SetObjFade(lua.gameObject, 0, 1,nil, timer / 2, delay)
			--node 
			UIUtil:SetPObjMove(lua.node, 0, 0, 100, 0, 0, 0, nil, timer, delay)
			--down 
			UIUtil:SetPObjMove(lua.down, 0, 0, - 380, - 330, 0, 0, nil, timer, delay)
			--stop
			self:SetStopAnim(lua.imgStop, timer, delay)
		end
	end
end

-- --透明度
-- function this:SetObjFade(obj, from, to, timer, delay)
-- 	local action = ComUtil.GetOrAddCom(obj, "ActionFade")
-- 	action.from = from
-- 	action.to = to
-- 	action.time = timer
-- 	action.delay = delay
-- 	action:ToPlay()
-- end

--stop
function this:SetStopAnim(obj, timer, delay)
	if(obj.activeInHierarchy) then
		local action = ComUtil.GetOrAddCom(obj, "ActionBase")
		action.time = timer
		action.delay = delay
		action:ToPlay()
	end
end


return this 
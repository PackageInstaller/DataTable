--上移补空位
local this = {}

local animTotalTime = 0.7 --动画总时长
local animTotalTime2 = 0.5 -- 实际时长

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

function this:AnimPlay(num)
	if(not self.layout) then
		return
	end	
	local indexs = self.layout:GetIndexs()
	local len = indexs.Length
	local startI = - 1
	local endI = len - 1
	for i = 0, len - 1 do
		local index = indexs[i]
		local lua = self.layout:GetItemLua(index)
		if(lua) then
			if((i + 1) > num) then
				--大于数据长度的隐藏处理
				CSAPI.SetAnchor(lua.gameObject, false)
			else
				if(lua and lua.gameObject.activeSelf == false) then
					if(startI == - 1) then
						startI = i
						endI = i
					else
						endI = i
					end
				end	
			end	
		end
	end
	
	if(startI ~= - 1) then
		local count = endI - startI + 1
		local perSizeArr = self.layout:GetPerSize()
		local isVertical = self.layout:GetIsVertical() == 1
		for i = startI, len - 1 do
			local index = indexs[i]
			local lua = self.layout:GetItemLua(index)
			if(lua) then
				local x1, y1, z1 = CSAPI.GetAnchor(lua.gameObject) --当前位置，即目标位置
				local x2, y2, z2 = x1, y1, z1
				if(isVertical) then
					y2 = y2 - count * perSizeArr[1]
				else
					x2 = x2 + count * perSizeArr[0]
				end
				CSAPI.SetGOActive(lua.gameObject, true)
				self:SetObjMove(lua.gameObject, x2, y2, z2, x1, y1, z1)
			end
		end
	end
end

--x/y方向移动
function this:SetObjMove(obj, x1, y1, z1, x2, y2, z2)
	local action = ComUtil.GetOrAddCom(obj, "ActionUIMoveTo")
	CSAPI.SetAnchor(obj, x1, y1, z1)
	action:SetStartPos(x1, y1, z1)
	action:SetTargetPos(x2, y2, z2)
	action.isLocal = true
	action.time = animTotalTime * 1000
	action:ToPlay()
end

function this:AnimAgain()
    --self.layout.animTotalTime = animTotalTime -- 重设时间，调用IEShowList会重新播放一次动画
    self.layout:AnimAgain()
end

return this 
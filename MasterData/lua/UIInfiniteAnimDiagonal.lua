--对角线生成 角色系统、背包系统、编成选角色
--设计一条45度角的直线，向右边推进
local this = {}

local animTotalTime = 0.7 --动画总时长
local animTotalTime2 = 0.5 -- 实际时
local angle = 45          --推荐线与x轴的夹角

function this.New()
	this.__index = this.__index or this
	local ins = {}
	setmetatable(ins, this)
	return ins
end

function this:InitData(_layout, _param)
	self.layout = _layout
	self.layout.animTotalTime = animTotalTime
	self.param = _param
end

function this:AnimPlay()
	if(not self.layout) then
		return
	end
	local indexs = self.layout:GetIndexs()
	local len = indexs.Length
	local minPos = UnityEngine.Vector2(- 1, 0)   --左上 直线A点
	local maxPos = UnityEngine.Vector2(self.layout.width, - self.layout.height) --右下位置
	local lenX = maxPos.x - minPos.x
	local lenY = minPos.y - maxPos.y
	local lenX1 = lenY / math.tan(angle)
	local x1 = minPos.x - lenX1
	local B = UnityEngine.Vector2(x1, maxPos.y) --直线B点
	local k = math.tan(angle)
	local b = 0
	local lenX2 = lenX1 + lenX    --直线需要向右移动的距离
	local num = self.layout.limit * 2         --值越大越平滑
	local curNum = 0
	local nextB = UnityEngine.Vector2(x1, maxPos.y) --不能直接等于B，否则修改时就一起修改了(对象)
	local count = num + 1
	while(curNum <= count) do
		nextB.x = B.x + lenX2 *(curNum / num)
		b = nextB.y -(k * nextB.x)
		for i = 0, len - 1 do
			local index = indexs[i]
			if(index ~= - 1) then
				local posArr = self.layout:GetInfoPos(i+1) --(index)
				local isLeft = self:CheckIsLeft(k, b, posArr)
				if(isLeft) then
					local lua = self.layout:GetItemLua(index)
					if(lua and lua.gameObject) then
						local fade = ComUtil.GetOrAddCom(lua.gameObject, "ActionFade")
						local _delay = math.modf((animTotalTime2 *(curNum / num) * 1000) + 1)
						self:SetElseAnim(lua, _delay)
						fade:Play(0, 1, 150, _delay, nil)
					end
					indexs[i] = - 1
				end
			end
		end
		curNum = curNum + 1
	end
end

--额外的动画
function this:SetElseAnim(lua, delay)
	if(self.param and self.param == "showlvbar") then
		lua.SetColorBar(delay / 1000)
	end
end

--是否在直线左边
function this:CheckIsLeft(k, b, posArr)
	local y =(k * posArr[0]) + b
	return posArr[1] >= y
end

function this:AnimAgain()
	--self.layout.animTotalTime = animTotalTime  --重设时间，调用IEShowList会重新播放一次动画
	self.layout:AnimAgain()
end

return this 
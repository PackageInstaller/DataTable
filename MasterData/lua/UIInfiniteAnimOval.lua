--椭圆动画 选关卡
--item到中点的距离与半屏的宽度的比值决定角度大小
local this = {}

function this.New()
	this.__index = this.__index or this
	local ins = {}
	setmetatable(ins, this)
	return ins
end

function this:InitData(_layout, _param)
	local arr = CSAPI.GetScreenSize()
	self.layout = _layout
	self.radiusW = arr[0]
	self.radiusZ = arr[1]
	self.cellSizeX = self.layout:GetCellSize() [0]
	self.cellSizeY = self.layout:GetCellSize() [1]
	
	self:InitAngle()
end

function this:AnimPlay()
	if(not self.layout) then
		return
	end
	local indexs = self.layout:GetIndexs()
	local len = indexs.Length
	for i = 0, len - 1 do
		local index = indexs[i]
		local lua = self.layout:GetItemLua(index)
		local x = self.layout.transform:InverseTransformPoint(lua.transform.position).x
		x = x + self.cellSizeX / 2
		local rate = x /(self.radiusW / 2 + self.cellSizeX / 2)
		if(math.abs(rate) <= 1) then
			local angle = - self.maxAngle * rate
			local rate2 = rate>0 and rate * rate  or -(rate * rate)
			local z = math.abs(self.radiusZ * rate2) / 2
			--位置
			ComUtil.GetCom(lua.node, "RectTransform").anchoredPosition3D = UnityEngine.Vector3(0, 0, z)  --TODO
			--CSAPI.SetAnchor(lua.node, 0, 0, z)
			--角度
			CSAPI.SetAngle(lua.node, 0, angle, 0)
		else		
			--位置
			ComUtil.GetCom(lua.node, "RectTransform").anchoredPosition3D = UnityEngine.Vector3(0, 10000, 0)
		end	
	end
end

function this:InitAngle()
	local tanValue = math.atan(math.abs(935 /(self.radiusW / 2)))
	self.maxAngle = tanValue / math.pi * 180
	self.maxAngle = self.maxAngle > 5 and(self.maxAngle - 5) or self.maxAngle
end


return this 
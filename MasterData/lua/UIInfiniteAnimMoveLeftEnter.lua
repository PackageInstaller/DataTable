--从右往左入场
local animTotalTime = 0.7 --动画总时长
local animTotalTime2 = 0.5 -- 实际时长

function this.New()
	this.__index = this.__index or this
	local ins = {}
	setmetatable(ins, this)
	return ins
end


function this:InitData(_layout, _xOffset)
	self.layout = _layout
	self.layout.animTotalTime = animTotalTime
	self.xOffset = _xOffset or 100;
end

function this:AnimPlay()
	if(not self.layout) then
		return
	end	
	local indexs = self.layout:GetIndexs()
	local len = indexs.Length
	local delay =(animTotalTime2 / len * 1000)
	for i = 0, len - 1 do
		local index = indexs[i]
		local lua = self.layout:GetItemLua(index)
		if(lua and lua.node) then
			--移动动画
			local x1, y1, z1 = CSAPI.GetAnchor(lua.node);
			local x2 = x1 + self.xOffset + 50 * math.modf(i / 2);
			local delayTime = math.modf(delay *(math.modf(i / 2) + 1));
			UIUtil:SetPObjMove(lua.node, x2, x1, y1, y1, z1, z1, nil, animTotalTime2 * 1000, delayTime);
			UIUtil:SetObjFade(lua.node, 0, 1, nil, 300, delayTime);
		end
	end
end

function this:AnimAgain()
	--self.layout.animTotalTime = animTotalTime  --重设时间，调用IEShowList会重新播放一次动画
	self.layout:AnimAgain()
end

return this 
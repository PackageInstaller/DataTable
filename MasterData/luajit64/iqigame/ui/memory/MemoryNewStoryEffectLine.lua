-- chunkname: @IQIGame\\UI\\Memory\\MemoryNewStoryEffectLine.lua

MemoryNewStoryEffectLine = {
	state = 1
}

function MemoryNewStoryEffectLine.New(go, parent, pos)
	local o = Clone(MemoryNewStoryEffectLine)

	o:CreateEffect(go, parent, pos)

	return o
end

function MemoryNewStoryEffectLine:CreateEffect(go, parent, pos)
	self.AnimGO = go

	self.AnimGO.transform:SetParent(parent, false)

	self.AnimGO.transform.localPosition = Vector3.New(pos[1], pos[2], pos[3])

	self:ShowState(self.state)
end

function MemoryNewStoryEffectLine:ShowState(state)
	self.state = state

	if self.AnimGO == nil then
		return
	end

	local goAnimation = self.AnimGO.transform:GetChild(0).gameObject

	goAnimation.transform:GetChild(0).gameObject:SetActive(state ~= 1)

	local animation = goAnimation:GetComponent(typeof(UnityEngine.Animation))

	if animation ~= nil then
		if state == 2 then
			animation:Play("FX_xinpiantuowei01")
		elseif state == 3 then
			animation:Play("FX_xinpiantuowei")
		end
	end
end

function MemoryNewStoryEffectLine:Dispose()
	UnityEngine.Object.Destroy(self.AnimGO)
end

return MemoryNewStoryEffectLine

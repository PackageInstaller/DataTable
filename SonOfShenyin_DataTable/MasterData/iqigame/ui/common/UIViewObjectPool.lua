-- chunkname: @IQIGame\\UI\\Common\\UIViewObjectPool.lua

local UIViewObjectPool = {
	pool = {}
}

function UIViewObjectPool.New(uiTemplate, uiParentTrans, createFunc)
	local obj = Clone(UIViewObjectPool)

	obj:__Init(uiTemplate, uiParentTrans, createFunc)

	return obj
end

function UIViewObjectPool:__Init(uiTemplate, uiParentTrans, createFunc)
	self.createFunc = createFunc
	self.template = uiTemplate

	if uiParentTrans == nil then
		self.templateParentTrans = uiTemplate.transform.parent
	else
		self.templateParentTrans = uiParentTrans
	end

	self.pool = {}
end

function UIViewObjectPool:GetFree(checkFreeFunc)
	for i = 1, #self.pool do
		if checkFreeFunc(self.pool[i]) then
			return self.pool[i]
		end
	end

	local itemObj = UnityEngine.Object.Instantiate(self.template)

	itemObj.transform:SetParent(self.templateParentTrans, false)

	local item = self.createFunc == nil and itemObj or self.createFunc(itemObj)

	table.insert(self.pool, item)

	return item
end

function UIViewObjectPool:ForItems(action)
	for i = 1, #self.pool do
		local result = action(self.pool[i])

		if result ~= nil then
			return
		end
	end
end

function UIViewObjectPool:Dispose(disposeFunc)
	for i = 1, #self.pool do
		disposeFunc(self.pool[i])
	end

	self.pool = nil
	self.createFunc = nil
	self.template = nil
	self.templateParentTrans = nil
end

return UIViewObjectPool

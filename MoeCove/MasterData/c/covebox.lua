

---@class CoveBox
local CoveBox = class("CoveBox")
function CoveBox:ctor(data)
	---@type CoveBoxReward
	self.data = data
	---@type integer
	self.uid = data.uid
	---@type integer
	self.id = data.id
	---@type boolean
	self.destroyed = false
	self:CreateModel()
end


function CoveBox:GetUID()
	return self.uid
end

function CoveBox:GetID()
	return self.id
end

function CoveBox:GetCoveContainerName()
	return Config.PrefabPath.CoveBox
end
---
function CoveBox:CreateModel(completeFun)
	if self.destroyed then
		LuaLogger.es("角色已经被删除")
		return
	end
	self.isCreate = true
	local modelName = self:GetCoveContainerName()
	if string.isNullOrEmpty(modelName) then
		LuaLogger.es("创建模型失败 路劲为空")
		return
	end
	PoolMgr:Get(modelName, function (modelObj)
		if self.destroyed then
			LuaLogger.es("角色已经被删除")
			PoolMgr.Free(modelObj)
			return
		end
		self.modelObj = modelObj
		self:OnModelLoadFinish()
		if completeFun then
			completeFun()
		end	
	end)
end


function CoveBox:OnModelLoadFinish()
	self.modelLoadFinish = true
	local pos = self.data.pos
	if pos == nil or tablex.empty(pos) then
		pos = {x = 0, y = 0, z = 0}
		LuaLogger.es("===>>>箱子位置错误")
	end
	local v3 = Vector3.New(pos.x / 100, 0, pos.z / 100)
	self.modelObj.transform.position = v3
end


function CoveBox:OnClick()
	Me:ReportGetHomelandBattleRewardBoxReq({self:GetUID()}, function(reward)
		CoveBattleMgr.instance():DeleteCoveBox(self:GetUID())
	end)
end

function CoveBox:Destroy()
	
	if self.destroyed then
		LuaLogger.es("CoveBox 重复删除错误" .. "   id:" .. tostring( self:GetID()))
		return
	end
	self.destroyed = true
	LuaLogger.ds("CoveBox 删除"  .. "   id:" .. tostring( self:GetID()))

	if UICommonUtils.Checkobj(self.modelObj) then
		PoolMgr.Free(self.modelObj)
		self.modelObj = nil
	end
end


return CoveBox
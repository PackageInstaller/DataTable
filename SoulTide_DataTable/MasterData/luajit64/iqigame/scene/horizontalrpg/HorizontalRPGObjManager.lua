-- chunkname: @IQIGame\\Scene\\HorizontalRPG\\HorizontalRPGObjManager.lua

local m = {
	HorizontalRPGElementPool = {},
	HorizontalBulletPool = {}
}
local HorizontalRPGElement = require("IQIGame.Scene.HorizontalRPG.Element.HorizontalRPGElement")
local HorizontalRPGBullet = require("IQIGame.Scene.HorizontalRPG.HorizontalRPGBullet")

function m.New(view, gameScene)
	local obj = Clone(m)

	obj:Init(view, gameScene)

	return obj
end

function m:Init(view, gameScene)
	self.View = view
	self.RootScene = gameScene

	LuaCodeInterface.BindOutlet(self.View, self)

	self.HorizontalRPGElementPool = {}
	self.HorizontalBulletPool = {}
end

function m:CheckBeyondBoundaries(sceneElement)
	if sceneElement.View.transform.position.x < self.RootScene.goLimitLeft.transform.position.x or sceneElement.View.transform.position.x > self.RootScene.goLimitRight.transform.position.x or sceneElement.View.transform.position.y > self.RootScene.goLimitUp.transform.position.y or sceneElement.View.transform.position.y < self.RootScene.goLimitDown.transform.position.y then
		return true
	end

	return false
end

function m:FrameUpdate()
	for i, v in pairs(self.HorizontalBulletPool) do
		if v.active then
			if self:CheckBeyondBoundaries(v) then
				self:RecycleBullet(v)
			end

			v:FrameUpdate()
		end
	end

	for areaID, areaElements in pairs(self.HorizontalRPGElementPool) do
		for pos, v in pairs(areaElements) do
			if v.Active then
				v:FrameUpdate()
			end
		end
	end
end

function m:FixedUpdate()
	for areaID, areaElements in pairs(self.HorizontalRPGElementPool) do
		for pos, v in pairs(areaElements) do
			if v.Active then
				v:FixedUpdate()
			end
		end
	end
end

function m:ChangeElementsRigidBodySimulated(simulated)
	for areaID, areaElements in pairs(self.HorizontalRPGElementPool) do
		for pos, v in pairs(areaElements) do
			if v.Active and v.ElementData and (v.ElementData:GetCfgData().ElementType == HorizontalRPGConstant.ElementType.HorizontalRPG_Element or v.ElementData:GetCfgData().ElementType == HorizontalRPGConstant.ElementType.HorizontalRPG_Case) then
				v.ElementRigidBody2D.simulated = simulated
			end
		end
	end
end

function m:CheckBulletCollision(collider2Ds, type, elementData)
	for i, v in pairs(self.HorizontalBulletPool) do
		if v.active then
			local res = false

			if type == HorizontalRPGConstant.ObjectType.HorizontalRPG_Player then
				if v.bulletData.launcher == HorizontalRPGConstant.ObjectType.HorizontalRPG_Element then
					res = v:CheckPlayerBoundsIntersects(collider2Ds)

					if res then
						if GameEntry.Base.DevMode then
							log("子弹打中角色了 发射者ID = " .. v.bulletData.firePayerID)
						end

						HorizontalRPGModule.ElementExecutionElse({
							90006
						})
						self:RecycleBullet(v)
					end
				end
			elseif type == HorizontalRPGConstant.ObjectType.HorizontalRPG_Element and v.bulletData.firePayerID ~= elementData.cid then
				res = v:CheckPlayerBoundsIntersects(collider2Ds)

				if res then
					if not v.bulletData:GetCfgData().IsLoop then
						if GameEntry.Base.DevMode then
							log("地图元素被打中了 元素ID " .. elementData.cid .. " 子弹发射者ID " .. v.bulletData.firePayerID)
						end

						if v.bulletData.launcher == HorizontalRPGConstant.ObjectType.HorizontalRPG_Player then
							GameEntry.Sound:PlaySound(HorizontalRPGConstant.Sound.ShootMonster, Constant.SoundGroup.CHARACTER)

							if GameEntry.Base.DevMode then
								log("播放放射中怪物音效 " .. HorizontalRPGConstant.Sound.ShootMonster)
							end
						end

						HorizontalRPGModule.TriggerElementService(HorizontalRPGConstant.ElementTriggerType.CollisionElementByBullet, elementData.cid)
					end

					self:RecycleBullet(v)
				end
			end
		end
	end
end

function m:GetBullet()
	for i, v in pairs(self.HorizontalBulletPool) do
		if not v.active and v.playEndEffect then
			return v
		end
	end

	local bulletCell = HorizontalRPGBullet.New(UnityEngine.Object.Instantiate(self.goBullet))

	self.HorizontalBulletPool[bulletCell.View:GetInstanceID()] = bulletCell

	return bulletCell
end

function m:RecycleBullet(bullet)
	bullet:Reset(true, function()
		bullet.View.transform:SetParent(self.RecoveryNode.transform, false)

		self.HorizontalBulletPool[bullet.View:GetInstanceID()] = bullet
	end)
end

function m:GetHorizontalRPGElement(areaID, pos)
	self.HorizontalRPGElementPool = self.HorizontalRPGElementPool or {}
	self.HorizontalRPGElementPool[areaID] = self.HorizontalRPGElementPool[areaID] or {}

	local rpgElement = self.HorizontalRPGElementPool[areaID][pos]

	if rpgElement then
		return rpgElement
	end

	local rpgElement = HorizontalRPGElement.New(UnityEngine.Object.Instantiate(self.goElement), self)

	self.HorizontalRPGElementPool[areaID][pos] = rpgElement

	return rpgElement
end

function m:RecycleHorizontalRPGElement(areaID)
	local rpgElements = self.HorizontalRPGElementPool[areaID]

	if rpgElements then
		for pos, element in pairs(rpgElements) do
			local isRecycle = true

			if element.ElementData and self.RootScene.PutBoxElement[element.ElementData.cid] then
				isRecycle = false
			end

			if isRecycle then
				element.View.transform:SetParent(self.RecoveryNode.transform, false)
				element:Reset()

				self.HorizontalRPGElementPool[areaID][pos] = element
			end
		end
	end
end

function m:DisPosAreaElement(areaID)
	for i, v in pairs(self.HorizontalRPGElementPool[areaID]) do
		v:Dispose()
	end
end

function m:DisPosMapElement()
	for areaID, areaElements in pairs(self.HorizontalRPGElementPool) do
		self:DisPosAreaElement(areaID)
	end

	self.HorizontalRPGElementPool = {}
end

function m:GetElementByID(elementID)
	for areaID, areaElements in pairs(self.HorizontalRPGElementPool) do
		for pos, element in pairs(areaElements) do
			if element.ElementData and element.ElementData.cid == elementID then
				return element
			end
		end
	end

	return nil
end

function m:Dispose()
	self:DisPosMapElement()

	for i, v in pairs(self.HorizontalBulletPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m

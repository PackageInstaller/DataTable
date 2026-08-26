-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyPlayerComp.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyPlayerComp", package.seeall)

local PartyGameLobbyPlayerComp = class("PartyGameLobbyPlayerComp", LuaCompBase)

function PartyGameLobbyPlayerComp:init(go)
	self._resLoader = SpinePrefabInstantiate.Create(go)
	self._resPath = PartyGameEnum.PartyGameSceneSpineRes

	self._resLoader:startLoad(self._resPath, self._resPath, self._onResLoaded, self)

	self._rootGo = go
	self._rootTrans = self._rootGo.transform

	transformhelper.setLocalPos(self._rootTrans, PartyGameLobbyEnum.InitPos.x, PartyGameLobbyEnum.InitPos.y, PartyGameLobbyEnum.InitPos.z)

	self._seeker = ZProj.AStarSeekWrap.Get(go)
	self._curPos = Vector3(PartyGameLobbyEnum.InitPos.x, PartyGameLobbyEnum.InitPos.y, PartyGameLobbyEnum.InitPos.z)
	self._targetPos = Vector3(PartyGameLobbyEnum.InitPos.x, PartyGameLobbyEnum.InitPos.y, PartyGameLobbyEnum.InitPos.z)
	self._followPathData = {}
	self._partyGameVectorPool = PartyGameVectorPool.instance
end

function PartyGameLobbyPlayerComp:_onResLoaded()
	self._spineGo = self._resLoader:getInstGO()
	self._spineComp = self._spineGo:AddComponent(typeof(PartyGame.Runtime.Spine.PartyGameLobbySceneSpine))

	gohelper.setLayer(self._spineGo, UnityLayer.Scene, true)

	if self._headSkinName then
		self:refreshSkin(self._hatSkinName, self._clothesSkinName, self._trousersSkinName, self._shoesSkinName, self._headSkinName, self._bodySkinName)
	end

	local renderer = self._spineGo:GetComponent(typeof(UnityEngine.MeshRenderer))

	renderer.sortingLayerID = 0
end

function PartyGameLobbyPlayerComp:onDestroy()
	self._seeker:RemoveOnPathCall()

	if self._resLoader then
		self._resLoader:dispose()
	end
end

function PartyGameLobbyPlayerComp:refreshSkin(hatSkinName, clothesSkinName, trousersSkinName, shoesSkinName, headSkinName, bodySkinName)
	if self._spineComp then
		self._spineComp:SetSkins(bodySkinName or "", headSkinName or "", trousersSkinName or "", shoesSkinName or "", hatSkinName or "", clothesSkinName or "")
	else
		self._bodySkinName = bodySkinName
		self._headSkinName = headSkinName
		self._trousersSkinName = trousersSkinName
		self._shoesSkinName = shoesSkinName
		self._hatSkinName = hatSkinName
		self._clothesSkinName = clothesSkinName
	end
end

function PartyGameLobbyPlayerComp:_tryGetPath(startPos, endPos, callback, callbackObj, param)
	self._seeker:RemoveOnPathCall()
	self._seeker:AddOnPathCall(callback, callbackObj, param)
	self._seeker:StartPath(startPos, endPos)
end

function PartyGameLobbyPlayerComp:setTargetPos(x, z)
	self._targetPos.x = x
	self._targetPos.z = z

	self._tryGetPath(self, self._curPos, self._targetPos, self._onPathCallback, self)
end

function PartyGameLobbyPlayerComp:getPosZ()
	local x, y, z = transformhelper.getPos(self._rootTrans)

	return z
end

function PartyGameLobbyPlayerComp:_onPathCallback(param, pathList, isError, errorMsg)
	if not isError then
		local list = self._partyGameVectorPool:packPosList(pathList)

		self:_setPathDataPosList(list)
	else
		self:_setPathDataPosList(nil)
		logNormal("PartyGameLobbyPlayerComp pathfinding Error : " .. tostring(errorMsg))
	end

	self:_checkMovePath()
end

function PartyGameLobbyPlayerComp:_checkMovePath()
	if #self._followPathData > 0 then
		local pos = table.remove(self._followPathData, 1)

		self._targetPosX = pos.x
		self._targetPosZ = pos.z

		self._partyGameVectorPool:recycle(pos)
	end
end

function PartyGameLobbyPlayerComp:_setPathDataPosList(posList)
	if #self._followPathData > 0 then
		for i, pos in ipairs(self._followPathData) do
			self._partyGameVectorPool:recycle(pos)
		end

		tabletool.clear(self._followPathData)
	end

	if posList and #posList > 0 then
		for i = #posList, 2, -1 do
			table.insert(self._followPathData, posList[i])
		end

		table.insert(self._followPathData, self._targetPos:Clone())
	end
end

function PartyGameLobbyPlayerComp:setRootInitPos(x, z)
	self._curPos.x = x
	self._curPos.z = z

	transformhelper.setLocalPos(self._rootTrans, x, PartyGameLobbyEnum.InitPos.y, z)
end

function PartyGameLobbyPlayerComp:update()
	self:_move()
end

function PartyGameLobbyPlayerComp:_move()
	if self._targetPosX == nil or self._targetPosZ == nil then
		return
	end

	local x, y, z = transformhelper.getPos(self._rootTrans)
	local length = PartyGameLobbyEnum.PlayerMoveSpeed * Time.deltaTime
	local angle = math.atan2(self._targetPosZ - z, self._targetPosX - x)
	local deltaX = length * math.cos(angle)
	local deltaZ = length * math.sin(angle)
	local x = x + deltaX
	local z = z + deltaZ
	local animator = self:getAnimator()

	if length >= math.abs(x - self._targetPosX) and length >= math.abs(z - self._targetPosZ) then
		transformhelper.setPos(self._rootTrans, self._targetPosX, y, self._targetPosZ)

		self._targetPosX = nil
		self._targetPosZ = nil

		self:_checkMovePath()

		if self._targetPosX or self._targetPosZ then
			return
		end

		if self._isMoving and animator then
			animator:SetBool("isMove", false)
			animator:SetFloat("speed", 0)
		end

		self._isMoving = false

		return
	end

	self._curPos.x = x
	self._curPos.z = z

	transformhelper.setPos(self._rootTrans, x, y, z)

	if self._spineComp then
		local deltaX = self._targetPosX - x

		if deltaX ~= 0 then
			local dir = deltaX > 0 and -1 or 1

			self._spineComp:SetScaleX(dir)
		end
	end

	if animator then
		animator:SetFloat("speed", 10)
		animator:SetBool("isMove", true)
	end

	self._isMoving = true
end

function PartyGameLobbyPlayerComp:getRootGo()
	return self._rootGo
end

function PartyGameLobbyPlayerComp:getSpineComp()
	return self._spineComp
end

function PartyGameLobbyPlayerComp:getAnimator()
	if not self._spineGo then
		return nil
	end

	self._animator = self._animator or self._spineGo:GetComponent("Animator")

	return self._animator
end

function PartyGameLobbyPlayerComp:onUpdateMO(mo)
	self._mo = mo
end

function PartyGameLobbyPlayerComp:getPlayerInfo()
	return self._mo
end

return PartyGameLobbyPlayerComp

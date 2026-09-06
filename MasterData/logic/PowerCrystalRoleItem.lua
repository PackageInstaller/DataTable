-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powercrystal/view/PowerCrystalRoleItem.lua

module("logic.extensions.powercrystal.view.PowerCrystalRoleItem", package.seeall)

local PowerCrystalRoleItem = class("PowerCrystalRoleItem")

function PowerCrystalRoleItem:ctor(go)
	self.mainGO = go.gameObject
	self.is_loaded = true

	self:buildUI()
	self:bindEvents()

	if self.needRefresh then
		self:setData(self.data, self.index)
	end

	if self.position then
		self:setPosition(self.position.x, self.position.y)

		self.position = nil
	end
end

function PowerCrystalRoleItem:bindEvents()
	return
end

function PowerCrystalRoleItem:unbindEvent()
	PowerCrystalView.super.unbindEvents(self)
	GameUtil.RemoveLua(self.mainGO, PowerCrystalRoleItem)
end

function PowerCrystalRoleItem:buildUI()
	local mainGO = self.mainGO

	self.roleCon = goutil.findChild(mainGO, "roleCon")
	self.txtLv = goutil.findChildTextComponent(mainGO, "txtLv")
	self._imgBg_1 = goutil.findChild(self.mainGO, "mask/imgBg_1")
end

function PowerCrystalRoleItem:OnDestroy()
	self:unbindEvent()
end

function PowerCrystalRoleItem:setData(data, index)
	self.data = data
	self.index = index

	if self.is_loaded then
		self.needRefresh = false

		if not data then
			self.txtLv.text = ""

			return
		end

		self.txtLv.text = data and string.format("<color=%s>%d 级</color>", index == 5 and "#0bff54ff" or "#ffffff", data.level) or ""

		local cfg = CharacterConfig.instance:getPetCo(data.raceId)

		if not cfg then
			printError("t_pet id not exist:" .. rid)

			return
		end

		local modelCo = CharacterConfig.instance:getModelCo(checknumber(cfg.faceIds))

		if not modelCo then
			printError("t_model id not exist:" .. cfg.faceIds)

			return
		end

		print("==modelCo.resName", modelCo.resName)
		uGuiUtil.setSpriteToImage(self._imgBg_1, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	else
		self.needRefresh = true
	end
end

function PowerCrystalRoleItem:setPosition(x, y)
	if self.is_loaded then
		GameUtil.setLocalPos(self.mainGO, x, y, 0)
	else
		self.position = Vector2.New(x, y)
	end
end

return PowerCrystalRoleItem

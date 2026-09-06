-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatarobject/AvatarUIBG.lua

module("logiccommon.common.avatar.avatarobj.AvatarUIBG", package.seeall)

local AvatarUIBG = class("AvatarUIBG", AvatarObject)

function AvatarUIBG:ctor(ctrl)
	AvatarUIBG.super.ctor(self)

	self._ctrl = ctrl
	self._bgId = nil
	self._bgEff = nil
end

function AvatarUIBG:destroy()
	AvatarUIBG.super.destroy(self)

	self._ctrl = nil
end

function AvatarUIBG:setParent(parent)
	AvatarUIBG.super.setParent(self, parent)

	local resObject = self:getGameObject()

	if resObject then
		resObject.transform:SetAsLastSibling()
	end
end

function AvatarUIBG:reset()
	if self._bgEff then
		UIEffectManager.instance:stopEffect(self._bgEff)

		self._bgEff = nil
	end

	if self:getGameObject() then
		uGuiUtil.clearImage(self:getGameObject())
	end

	self._assetPath = nil

	self._resLoader:clear()

	self._bgId = nil
end

function AvatarUIBG:switchId(uiBGId)
	if self._bgId ~= uiBGId then
		self._bgId = uiBGId

		self:loadPrefab()
	end
end

function AvatarUIBG:loadedHandle(loader)
	if loader == self._resLoader then
		AvatarUIBG.super.loadedHandle(self, loader)

		local resObject = self:getResObject()

		if self:getGameObject() then
			self:_loadPicAndEff()
		end
	end
end

function AvatarUIBG:callBackHandle(loader)
	if loader == self._resLoader then
		AvatarUIBG.super.callBackHandle(self, loader)
		self:_loadPicAndEff()
	end
end

function AvatarUIBG:loadPrefab()
	local resPath = "avatars/skinedmeshes/uibg/avatar_general_uibg.prefab"

	self:load(resPath)
end

function AvatarUIBG:_loadPicAndEff()
	local go = self:getGameObject()

	if go then
		local cfg = AvatarConfig.instance:getPartCfgById(self._bgId)
		local bgPicPath = cfg and cfg.bgPicPath

		if not GameUtil.isEmptyString(bgPicPath) then
			uGuiUtil.setSpriteToImage(go, uGuiUtil.SpriteType.BigBg, GameUrl.getUIBGPicUrl(bgPicPath), function()
				local img = go:GetComponent(typeof(UnityEngine.UI.Image))

				img:SetNativeSize()

				local width, height = GameUtil.getWidth(go), GameUtil.getHeight(go)
				local ratio = 1

				if height < 720 then
					ratio = 720 / height
				end

				width = width * ratio

				GameUtil.setWidth(go, width)
				GameUtil.setHeight(go, Mathf.Max(height, 720))

				height = GameUtil.getHeight(go)
				width = GameUtil.getWidth(go)

				if width < 1600 then
					ratio = 1600 / width
				end

				height = height * ratio

				GameUtil.setWidth(go, Mathf.Max(width, 1600))
				GameUtil.setHeight(go, height)
				self:setVisible(true)
			end)
		else
			self:setVisible(false)
		end

		if self._bgEff then
			UIEffectManager.instance:stopEffect(self._bgEff)

			self._bgEff = nil
		end

		local effPath = cfg and cfg.bgEffPath
		local effPos = goutil.findChild(go, "eff")

		if not GameUtil.isEmptyString(effPath) then
			local truePath = effPath .. ".prefab"

			self._bgEff = UIEffectManager.instance:playEffect(self._ctrl:getBGEffView(), truePath, effPos, 0, 0, true, nil, nil, function(view, uiEff)
				uiEff:setParent(effPos.transform)
				uiEff:setLocalPos(0, 0, 0)
				uiEff:setScale(1)
			end)
		end
	end
end

return AvatarUIBG

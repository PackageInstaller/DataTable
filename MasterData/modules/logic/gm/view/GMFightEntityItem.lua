-- chunkname: @modules/logic/gm/view/GMFightEntityItem.lua

module("modules.logic.gm.view.GMFightEntityItem", package.seeall)

local GMFightEntityItem = class("GMFightEntityItem", ListScrollCell)

function GMFightEntityItem:init(go)
	self._go = go
	self._btn = gohelper.findChildButtonWithAudio(go, "btn")
	self._selectImg = gohelper.findChildImage(go, "btn")
	self._icon = gohelper.findChildSingleImage(go, "image")
	self._imgIcon = gohelper.findChildImage(go, "image")
	self._imgCareer = gohelper.findChildImage(go, "image/career")
	self._txtName = gohelper.findChildText(go, "btn/name")
	self._txtId = gohelper.findChildText(go, "btn/id")
	self._txtUid = gohelper.findChildText(go, "btn/uid")
end

function GMFightEntityItem:addEventListeners()
	self._btn:AddClickListener(self._onClickThis, self)
end

function GMFightEntityItem:removeEventListeners()
	self._btn:RemoveClickListener()
end

function GMFightEntityItem:onUpdateMO(mo)
	self._mo = mo

	self._icon:UnLoadImage()

	if self._mo:isMonster() then
		if not lua_monster.configDict[self._mo.modelId] then
			local skinCO = FightConfig.instance:getSkinCO(mo.originSkin)

			if self._mo:isCharacter() then
				local iconPath = ResUrl.getHeadIconSmall(skinCO.retangleIcon)

				self._icon:LoadImage(iconPath)
			elseif self._mo:isMonster() then
				gohelper.getSingleImage(self._imgIcon.gameObject):LoadImage(ResUrl.monsterHeadIcon(skinCO.headIcon))

				self._imgIcon.enabled = true
			end

			local career = mo:getCareer()

			if career ~= 0 then
				UISpriteSetMgr.instance:setEnemyInfoSprite(self._imgCareer, "sxy_" .. tostring(career))
			end

			local isCharacter = self._mo:isCharacter()
			local isSpecial = FightDataHelper.entityMgr:isSp(self._mo.id)
			local isSub = FightDataHelper.entityMgr:isSub(self._mo.id)
			local isDead = FightDataHelper.entityMgr:isDeadUid(self._mo.id)
			local characterDesc = isSpecial and "特殊怪" or (isSub and "<color=#FFA500>替补</color>" or "") .. (isCharacter and "角色" or "怪物")

			self._txtName.text = self._mo.id == FightEntityScene.MySideId and "维尔汀" or self._mo.id == FightEntityScene.EnemySideId and "敌方维尔汀" or string.format("%s--%s", characterDesc, self._mo:getEntityName())
			self._txtId.text = "ID" .. tostring(self._mo.id)
			self._txtUid.text = "UID" .. tostring(self._mo.modelId)

			local txtColor = isDead and "#AAAAAA" or isCharacter and "#539450" or "#9C4F30"

			SLFramework.UGUI.GuiHelper.SetColor(self._txtName, txtColor)
			SLFramework.UGUI.GuiHelper.SetColor(self._txtId, txtColor)
			SLFramework.UGUI.GuiHelper.SetColor(self._txtUid, txtColor)
			ZProj.UGUIHelper.SetGrayscale(self._icon.gameObject, isDead)
		end
	end
end

function GMFightEntityItem:onDestroy()
	self._icon:UnLoadImage()
end

function GMFightEntityItem:_onClickThis()
	if not self._isSelect then
		self._view:setSelect(self._mo)
	end
end

function GMFightEntityItem:onSelect(isSelect)
	self._isSelect = isSelect

	SLFramework.UGUI.GuiHelper.SetColor(self._selectImg, isSelect and "#9ADEF0" or "#FFFFFF")

	if isSelect then
		GMFightEntityModel.instance:setEntityMO(self._mo)
		GMController.instance:dispatchEvent(GMFightEntityView.Evt_SelectHero, self._mo)
	end
end

return GMFightEntityItem

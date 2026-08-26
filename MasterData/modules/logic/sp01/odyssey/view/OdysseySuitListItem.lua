-- chunkname: @modules/logic/sp01/odyssey/view/OdysseySuitListItem.lua

module("modules.logic.sp01.odyssey.view.OdysseySuitListItem", package.seeall)

local OdysseySuitListItem = class("OdysseySuitListItem", LuaCompBase)

function OdysseySuitListItem:init(go)
	self.viewGO = go
	self._goUnEffect = gohelper.findChild(self.viewGO, "uneffect")
	self._imageicon = gohelper.findChildImage(self.viewGO, "uneffect/#image_icon")
	self._txtSuitName = gohelper.findChildText(self.viewGO, "uneffect/#txt_SuitName")
	self._txtLevel = gohelper.findChildText(self.viewGO, "uneffect/#txt_Level")
	self._goEffect = gohelper.findChild(self.viewGO, "effect")
	self._imageiconEffect = gohelper.findChildImage(self.viewGO, "effect/#image_icon")
	self._txtnum = gohelper.findChildText(self.viewGO, "effect/Num/#txt_num")
	self._txtSuitNameEffect = gohelper.findChildText(self.viewGO, "effect/#txt_SuitName")
	self._txtLevelEffect = gohelper.findChildText(self.viewGO, "effect/#txt_Level")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseySuitListItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function OdysseySuitListItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function OdysseySuitListItem:_btnclickOnClick()
	local param = {}

	param.suitId = self.id
	param.bagType = OdysseyEnum.BagType.FightPrepare
	param.pos = recthelper.uiPosToScreenPos(self.viewGO.transform)

	OdysseyController.instance:openSuitTipsView(param)
end

function OdysseySuitListItem:_editableInitView()
	self._effectFlashGO = gohelper.findChild(self.viewGO, "effect/BG/vx_flash")
	self.curEffectState = nil
	self.curSuitLevel = 0
end

function OdysseySuitListItem:setInfo(id)
	self.id = id
end

function OdysseySuitListItem:refreshUI()
	local curHeroGroupMo = OdysseyHeroGroupModel.instance:getCurHeroGroup()
	local id = self.id
	local config = OdysseyConfig.instance:getEquipSuitConfig(id)
	local suitInfo = curHeroGroupMo:getOdysseyEquipSuit(id)
	local effectConfigList = OdysseyConfig.instance:getEquipSuitAllEffect(id)
	local totalLevelCount = #effectConfigList
	local levelDescTable = {}
	local haveEffect = false

	if suitInfo ~= nil then
		for i = 1, totalLevelCount do
			local levelConfig = effectConfigList[i]

			if suitInfo and suitInfo.count >= levelConfig.number then
				haveEffect = true

				break
			end
		end
	end

	if (self.curSuitLevel < suitInfo.level and self.curSuitLevel > 0 or self.curEffectState == false) and haveEffect then
		gohelper.setActive(self._effectFlashGO, false)
		gohelper.setActive(self._effectFlashGO, true)
	end

	self.curSuitLevel = suitInfo.level
	self.curEffectState = haveEffect

	gohelper.setActive(self._goEffect, haveEffect)
	gohelper.setActive(self._goUnEffect, not haveEffect)

	if not haveEffect then
		if not self._txtSuitName then
			local textName = self._txtSuitNameEffect

			if not haveEffect then
				if not self._txtLevel then
					local textLevel = self._txtLevelEffect

					if not haveEffect then
						if not self._imageicon then
							local imageIcon = self._imageiconEffect
							local colorStart = not haveEffect and "" or "<color=#ECDFBD>%s"
							local colorEnd = not haveEffect and "" or "%s</color>"
							local endColor = false

							for i = 1, totalLevelCount do
								local levelConfig = effectConfigList[i]

								table.insert(levelDescTable, tostring(levelConfig.number))

								if haveEffect and suitInfo.level <= levelConfig.level and endColor == false then
									endColor = true
									levelDescTable[i] = string.format(colorEnd, levelDescTable[i])
								end
							end

							if haveEffect then
								levelDescTable[1] = string.format(colorStart, levelDescTable[1])
							end

							textLevel.text = table.concat(levelDescTable, "/")
							textName.text = config.name

							UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(imageIcon, config.icon)

							self._txtnum.text = tostring(suitInfo.count)
						end
					end
				end
			end
		end
	end
end

function OdysseySuitListItem:setActive(active)
	gohelper.setActive(self.viewGO, active)
end

function OdysseySuitListItem:onDestroy()
	return
end

return OdysseySuitListItem

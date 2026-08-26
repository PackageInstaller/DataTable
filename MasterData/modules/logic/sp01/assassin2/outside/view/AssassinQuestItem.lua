-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinQuestItem.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinQuestItem", package.seeall)

local AssassinQuestItem = class("AssassinQuestItem", LuaCompBase)

function AssassinQuestItem:init(go)
	self.go = go
	self.trans = go.transform
	self._imageicon = gohelper.findChildImage(self.go, "image_icon")
	self._goselect = gohelper.findChild(self.go, "go_select")
	self._gounselect = gohelper.findChild(self.go, "go_unselect")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._animator = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.go)
	self._questId = nil
end

function AssassinQuestItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function AssassinQuestItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function AssassinQuestItem:_btnclickOnClick()
	if self._questId then
		AssassinController.instance:clickQuestItem(self._questId, false, true)
	end
end

function AssassinQuestItem:setData(questId)
	self._questId = questId

	self:setIcon()
	self:setCfgPos()
	self:refreshSelected(false)
	gohelper.setActive(self.go, true)
end

function AssassinQuestItem:setIcon()
	local questType = AssassinConfig.instance:getQuestType(self._questId)

	AssassinHelper.setQuestTypeIcon(questType, self._imageicon)
end

function AssassinQuestItem:setCfgPos()
	local pos = AssassinConfig.instance:getQuestPos(self._questId)

	if not string.nilorempty(pos) then
		local posParam = string.splitToNumber(pos, "#")

		self:setPosition(posParam[1], posParam[2])
	else
		logError(string.format("AssassinQuestItem:setCfgPos error, pos is nil, questId = %s", self._questId))
	end
end

function AssassinQuestItem:setPosition(posX, posY)
	recthelper.setAnchor(self.trans, posX or 0, posY or 0)
end

function AssassinQuestItem:refreshSelected(isSelect)
	gohelper.setActive(self._goselect, isSelect)
	gohelper.setActive(self._gounselect, not isSelect)
end

function AssassinQuestItem:remove(isPlayAnim)
	if isPlayAnim then
		if self._animatorPlayer then
			self._animatorPlayer:Play(UIAnimationName.Close, self.disableItem, self)

			local cacheKey = AssassinHelper.getPlayerCacheDataKey(AssassinEnum.PlayerCacheDataKey.QuestItemFinishAnim, self._questId)

			AssassinController.instance:setHasPlayedAnimation(cacheKey)
		end
	else
		self:disableItem()
	end

	self._questId = nil
end

function AssassinQuestItem:disableItem()
	gohelper.setActive(self.go, false)
end

function AssassinQuestItem:playOpen()
	gohelper.setActive(self.go, true)

	if self._questId and self._animatorPlayer then
		self._animatorPlayer:Play(UIAnimationName.Open)
	end
end

function AssassinQuestItem:getQuestId()
	return self._questId
end

function AssassinQuestItem:getPosition()
	local posX, posY = recthelper.getAnchor(self.trans)

	return posX, posY
end

function AssassinQuestItem:getGoPosition()
	return self.trans.position
end

function AssassinQuestItem:onDestroy()
	self._questId = nil
end

return AssassinQuestItem

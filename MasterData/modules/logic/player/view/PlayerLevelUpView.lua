-- chunkname: @modules/logic/player/view/PlayerLevelUpView.lua

module("modules.logic.player.view.PlayerLevelUpView", package.seeall)

local PlayerLevelUpView = class("PlayerLevelUpView", BaseView)

function PlayerLevelUpView:onInitView()
	self._simagebgbar = gohelper.findChildSingleImage(self.viewGO, "#simage_bgbar")
	self._txtlevelbefore = gohelper.findChildText(self.viewGO, "level/#txt_levelbefore")
	self._txtlevelafter = gohelper.findChildText(self.viewGO, "level/#txt_levelafter")
	self._txtlevelafteeffect = gohelper.findChildText(self.viewGO, "level/#txt_levelafteeffect")
	self._gomaxpower = gohelper.findChild(self.viewGO, "up/#go_maxpower")
	self._txtmaxpower = gohelper.findChildText(self.viewGO, "up/#go_maxpower/#go_BG/#txt_maxpower")
	self._txtnextpower = gohelper.findChildText(self.viewGO, "up/#go_maxpower/#go_BG/#txt_maxpower/#txt_nextpower")
	self._gopower = gohelper.findChild(self.viewGO, "up/#go_power")
	self._txtpower = gohelper.findChildText(self.viewGO, "up/#go_power/#txt_power")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerLevelUpView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function PlayerLevelUpView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function PlayerLevelUpView:_btncloseOnClick()
	if not self._canClose then
		return
	end

	self:closeThis()
end

function PlayerLevelUpView:_editableInitView()
	self._simagebgbar:LoadImage(ResUrl.getMessageIcon("bg_tc1"))

	self._animation = self.viewGO:GetComponent(typeof(UnityEngine.Animation))

	if self._animation then
		self._animation:Play("levelup", UnityEngine.PlayMode.StopAll)
		self._animation:PlayQueued("levelup_loop", UnityEngine.QueueMode.CompleteOthers, UnityEngine.PlayMode.StopAll)
	end

	TaskDispatcher.runDelay(self._setCanClose, self, 1.8)
end

function PlayerLevelUpView:_setCanClose()
	self._canClose = true
end

function PlayerLevelUpView:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LevelUp)

	local playerInfo = PlayerModel.instance:getPlayinfo()
	local level = playerInfo.level
	local prelevel = math.max(playerInfo.level - self._levelup, 1)

	self._txtlevelbefore.text = prelevel
	self._txtlevelafter.text = level
	self._txtlevelafteeffect.text = level

	local playerLevelConfig = PlayerConfig.instance:getPlayerLevelCO(level)
	local preLevelConfig = PlayerConfig.instance:getPlayerLevelCO(prelevel)

	if playerLevelConfig.maxAutoRecoverPower > preLevelConfig.maxAutoRecoverPower then
		gohelper.setActive(self._gomaxpower, true)

		self._txtmaxpower.text = string.format(luaLang("player_levelup_maxpower"), preLevelConfig.maxAutoRecoverPower)
		self._txtnextpower.text = playerLevelConfig.maxAutoRecoverPower
	else
		gohelper.setActive(self._gomaxpower, false)
	end

	local totalAddUpRecoverPower = 0

	if prelevel < level then
		for lv = prelevel, level - 1 do
			local lvConfig = PlayerConfig.instance:getPlayerLevelCO(lv)

			totalAddUpRecoverPower = totalAddUpRecoverPower + ((lvConfig or nil) and (lvConfig.addUpRecoverPower or 0))
		end
	end

	if totalAddUpRecoverPower > 0 then
		gohelper.setActive(self._gopower, true)

		self._txtpower.text = string.format(luaLang("player_levelup_power"), totalAddUpRecoverPower)
	else
		gohelper.setActive(self._gopower, false)
	end
end

function PlayerLevelUpView:onUpdateParam()
	self._levelup = self.viewParam or 1

	self:_refreshUI()
end

function PlayerLevelUpView:onOpen()
	self._levelup = self.viewParam or 1

	self:_refreshUI()
end

function PlayerLevelUpView:onClose()
	return
end

function PlayerLevelUpView:onDestroyView()
	TaskDispatcher.cancelTask(self._setCanClose, self)
	self._simagebgbar:UnLoadImage()
end

return PlayerLevelUpView

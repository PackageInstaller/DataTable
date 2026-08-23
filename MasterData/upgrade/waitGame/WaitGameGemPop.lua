local var_0_0 = g.core.model.User.waitGameData
local var_0_1 = g.core.const.ConstMgr.WaitGameConst
local WaitGameGemPop = class("WaitGameGemPop", require("app.fairyGUI.upgrade.UI_WaitGameGemPop"), function()
	return fgui.GComponent:create({
		resName = "WaitGameGemPop",
		pkgPath = "ui/upgrade/upgrade",
		pkgName = "upgrade"
	})
end)

function WaitGameGemPop:ctor(arg_2_1)
	self._isPause = arg_2_1.isPause or false
	self._isPlaying = false

	self:showAtCenter()
	self:_initRegisterUI()
end

function WaitGameGemPop:onLoad()
	self:_updateMainView()
	self.m_enterTransition:play()

	self._lastBgm = g.core.sound.SoundManager:getCurBgm() or g.core.const.ConstMgr.SoundConst.BGM.MUSIC_LOGIN

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.GEM_ELI_BGM)

	if self._isPause then
		self:newScheduleOnce(handler(self, self._resumeDownload), var_0_1.DELAY_TIP_TIME)
	end
end

function WaitGameGemPop:_resumeDownload()
	g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
		singleButton = true,
		title = g.core.lang:get(1257),
		onConfirm = handler(self, function()
			g.core.module.ModuleManager:popComponent()
		end),
		desc = g.core.lang:get(100055)
	})))
end

function WaitGameGemPop:_initRegisterUI()
	self.m_returnBtn:addClickListener(handler(self, self._onCloseSelf))
	self:addBg("bg/upgrade/bg_jm_minigame.jpg", false, nil, 1)
end

function WaitGameGemPop:_updateMainView()
	self.m_chessboardComp:updateWithInfo()
end

function WaitGameGemPop:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "COMP_EVENT_COMBO_CHANGE" then
		var_0_0:refreshCombo(arg_8_2.comboNum)
		self.m_chessboardComp:playComboAni(arg_8_2.comboNum)
		self.m_infoComp:setCombo(var_0_0:getMaxComboNum())
		self.m_infoComp:setScore(var_0_0:getTotalScore())
	elseif arg_8_1 == "ON_GAME_START_CLICK" and not self._isPlaying then
		self:onGameStart()
	end
end

function WaitGameGemPop:onGameStart()
	self:_onDrawCurtainByStringText(g.core.lang:get(405912), true, handler(self, function()
		self:_startGame()
	end))
end

function WaitGameGemPop:_startGame()
	self._isPlaying = true

	var_0_0:clearDataOnStartGame()
	self.m_chessboardComp:onStartGame()
end

function WaitGameGemPop:_onDrawCurtainByStringText(arg_12_1, arg_12_2, arg_12_3)
	g.core.module.ModuleManager:pushPopup(require("upgrade.waitGame.WaitGameTipsLinePop").new({
		title = tostring(arg_12_1),
		isCountDown = arg_12_2,
		callBack = handler(self, function()
			if arg_12_3 then
				arg_12_3()
			end
		end)
	}), {
		blackOpacity = 1,
		ignoreTouch = true
	})
end

function WaitGameGemPop:_onCloseSelf()
	self._isPlaying = false

	g.core.sound.SoundManager:playMusic(self._lastBgm)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return WaitGameGemPop

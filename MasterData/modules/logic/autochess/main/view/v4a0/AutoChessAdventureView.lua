-- chunkname: @modules/logic/autochess/main/view/v4a0/AutoChessAdventureView.lua

module("modules.logic.autochess.main.view.v4a0.AutoChessAdventureView", package.seeall)

local AutoChessAdventureView = class("AutoChessAdventureView", BaseView)

function AutoChessAdventureView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._goPoints = gohelper.findChild(self.viewGO, "#go_Points")
	self._goPointLight1 = gohelper.findChild(self.viewGO, "#go_Points/Point1/#go_PointLight1")
	self._goPointLight2 = gohelper.findChild(self.viewGO, "#go_Points/Point2/#go_PointLight2")
	self._goMain = gohelper.findChild(self.viewGO, "#go_Main")
	self._txtTitleM = gohelper.findChildText(self.viewGO, "#go_Main/#txt_TitleM")
	self._simageAdventureM = gohelper.findChildSingleImage(self.viewGO, "#go_Main/#simage_AdventureM")
	self._txtNameM = gohelper.findChildText(self.viewGO, "#go_Main/namebg/#txt_NameM")
	self._txtDescM = gohelper.findChildText(self.viewGO, "#go_Main/scroll_Desc/viewport/content/#txt_DescM")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Main/#btn_Right")
	self._goSub = gohelper.findChild(self.viewGO, "#go_Sub")
	self._goSubBg = gohelper.findChild(self.viewGO, "#go_Sub/#go_SubBg")
	self._goLoseStreak = gohelper.findChild(self.viewGO, "#go_Sub/#go_LoseStreak")
	self._txtLevel = gohelper.findChildText(self.viewGO, "#go_Sub/Level/#txt_Level")
	self._goEnable = gohelper.findChild(self.viewGO, "#go_Sub/Tag/#go_Enable")
	self._goDisable = gohelper.findChild(self.viewGO, "#go_Sub/Tag/#go_Disable")
	self._goDescItem = gohelper.findChild(self.viewGO, "#go_Sub/scroll_Desc/viewport/content/#go_DescItem")
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Sub/#btn_Left")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessAdventureView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnRight:AddClickListener(self._btnRightOnClick, self)
	self._btnLeft:AddClickListener(self._btnLeftOnClick, self)
end

function AutoChessAdventureView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
end

function AutoChessAdventureView:onClickModalMask()
	self:closeThis()
end

function AutoChessAdventureView:_btnLeftOnClick()
	self.isSub = false

	self.anim:Play("switch", 0, 0)
	TaskDispatcher.runDelay(self.delaySwitch, self, 0.1)
end

function AutoChessAdventureView:_btnRightOnClick()
	self.isSub = true

	self.anim:Play("switch", 0, 0)
	TaskDispatcher.runDelay(self.delaySwitch, self, 0.1)
end

function AutoChessAdventureView:_btnCloseOnClick()
	self:closeThis()
end

function AutoChessAdventureView:_editableInitView()
	self.anim = gohelper.findComponentAnim(self.viewGO)
end

function AutoChessAdventureView:onOpenFinish()
	self.anim.enabled = true
end

function AutoChessAdventureView:onOpen()
	local isEnemy = self.viewParam.isEnemy
	local txt = isEnemy and "autochessadventureview_enemy" or "autochessadventureview_mine"

	self._txtTitleM.text = luaLang(txt)

	local invalidLvl = AutoChessConfig.instance:getLoseStreakInvalidLvl()
	local actMo = Activity182Model.instance:getActMo()

	if actMo then
		if not actMo.rank then
			local curRank = 0
			local sceneMo = AutoChessModel.instance:getSceneMo(true)
			local mutationId

			if isEnemy then
				gohelper.setActive(self._btnLeft, false)
				gohelper.setActive(self._btnRight, false)
				gohelper.setActive(self._goPoints, false)

				if sceneMo then
					mutationId = sceneMo.fight.enemyMaster:getMutationId()
				end
			else
				local curLoseStreak = 0

				if sceneMo then
					local master = sceneMo.fight.mySideMaster

					mutationId = master:getMutationId()
					curLoseStreak = master.loseStreak
				else
					local gameMo = actMo:getGameMo(actMo.activityId, AutoChessEnum.EpisodeType.PVP)

					mutationId = gameMo.mutationId
				end

				if curRank < invalidLvl then
					local loseLvl = AutoChessConfig.instance:getLoseStreakLvl(curLoseStreak)
					local actId = Activity182Model.instance:getCurActId()
					local cfgs = lua_auto_chess_lose_streak_reward.configDict[actId]

					for i = 1, #cfgs do
						local config = cfgs[i]
						local go = gohelper.cloneInPlace(self._goDescItem)
						local goLight = gohelper.findChild(go, "go_Light")

						gohelper.setActive(goLight, loseLvl == i)

						local txtLevel = gohelper.findChildText(go, "txt_Level")

						txtLevel.text = "Lv." .. config.levelId

						local txtDesc = gohelper.findChildText(go, "txt_Desc")

						txtDesc.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("autochess_losingstreak_tip"), config.loseStreak, config.bonusCoin)
					end

					gohelper.setActive(self._goDescItem, false)
					gohelper.setActive(self._goDisable, loseLvl == 0)
					gohelper.setActive(self._goEnable, loseLvl ~= 0)
					ZProj.UGUIHelper.SetGrayscale(self._goLoseStreak, sceneMo and loseLvl == 0)
					ZProj.UGUIHelper.SetGrayscale(self._goSubBg, sceneMo and loseLvl == 0)

					self._txtLevel.text = "Lv." .. loseLvl
				else
					gohelper.setActive(self._btnLeft, false)
					gohelper.setActive(self._btnRight, false)
					gohelper.setActive(self._goPoints, false)
				end
			end

			if mutationId then
				local mutationCfg = AutoChessConfig.instance:getMutationCfg(mutationId)

				self._simageAdventureM:LoadImage(ResUrl.getAutoChessIcon(mutationCfg.icon, "adventure"))

				self._txtNameM.text = mutationCfg.name
				self._txtDescM.text = mutationCfg.desc
			end

			self.isSub = self.viewParam.isSub

			self:delaySwitch()
		end
	end
end

function AutoChessAdventureView:delaySwitch()
	gohelper.setActive(self._goPointLight1, not self.isSub)
	gohelper.setActive(self._goPointLight2, self.isSub)
	gohelper.setActive(self._goMain, not self.isSub)
	gohelper.setActive(self._goSub, self.isSub)
end

function AutoChessAdventureView:onDestroyView()
	TaskDispatcher.cancelTask(self.delaySwitch, self)
end

return AutoChessAdventureView

-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\CatRace\\ActivityCatRaceCatComp.lua

local ResOpActivityCatRaceCatDetail = require("ClientData/ResOpActivityCatRaceCatDetail")
local CatRaceConfig = require("UI/OpActivity/CatRace/CatRaceConfig")
local ResClientNotice = require("ClientData/ResClientNotice")
local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local strClassName = "ActivityCatRaceCatComp"
local ActivityCatRaceCatComp = Class(strClassName, UIBaseControl)

function ActivityCatRaceCatComp:ctor(parent, path)
	self.catPanel = UIControls.Panel(parent, path)
	self._giftBtn = UIControls.Button(parent, path .. "/FuncPanel/BtnGift")

	self._giftBtn:addEventClick(Slot(self._onBtnGiftSend, self))

	self._taskBtn = UIControls.Button(parent, path .. "/FuncPanel/BtnTask")

	self._taskBtn:addEventClick(Slot(self._onBtnFriendTask, self))

	self.playerNameTxt = UIControls.Label(parent, path .. "/BgTextName/Text")
	self.live2Dplayer = UIControls.LazyLivePlayer(parent, path .. "/CatLive2DPanel")
	self.funcAnim = UIControls.UIAni(parent, path .. "/FuncPanel")
	self.closeBtn = UIControls.Button(parent, path .. "/BtnClose")

	self.closeBtn:addEventClick(Slot(self._onBtnClose, self))
	self.closeBtn:setVisible(false)

	self.touchBtn = UIControls.Button(parent, path)

	self.touchBtn:addEventClick(Slot(self._onBtnTouch, self))

	self.emptyClickPanel = UIControls.Panel(parent, path .. "/CatLive2DPanel/EmptyClick")
	self.giftImg = UIControls.Image(parent, path .. "/FuncPanel/BtnGift")
	self.showEfx = UIControls.LazyEffectPlayer(parent, path .. "/EfxShow")
	self.bgNameImg = UIControls.Image(parent, path .. "/BgTextName")
end

function ActivityCatRaceCatComp:setData(data, mainActID)
	self.playerInfo = data
	self.mainActID = mainActID
	self.mainActObj = CurAvatar:getActivityObj(self.mainActID)

	local mainUI = UIManager.tryGetUI("activityCatRaceMainDlg")

	if not mainUI or not self:getController() then
		return
	end

	if self.mainActObj then
		self.mainActData = self.mainActObj.actData
		self.mainOpID = self.mainActObj.opId

		if self.mainActData:checkFriendIsComp(self.playerInfo.uid) then
			self.bgNameImg:setImage("Atlas/ActivityAtlas/ActivityCatRaceAtlas/ActivityCatRaceAtlas", "BgMyTip")
		else
			self.bgNameImg:setImage("Atlas/ActivityAtlas/ActivityCatRaceAtlas/ActivityCatRaceAtlas", "BgOtherTip")
		end

		self.playerNameTxt:setText(utils.format(Lang.get(52478), self.playerInfo.name))

		local color_id = CatRaceConfig.CAT_DEFAULT_COLOR

		if self.playerInfo.opActSimpleItem and self.playerInfo.opActSimpleItem.specdata and self.playerInfo.opActSimpleItem.specdata.cat_race and self.playerInfo.opActSimpleItem.specdata.cat_race.cat_info and self.playerInfo.opActSimpleItem.specdata.cat_race.cat_info.color_id ~= 0 then
			color_id = self.playerInfo.opActSimpleItem.specdata.cat_race.cat_info.color_id
		end

		self.catDetailData = ResOpActivityCatRaceCatDetail[self.mainActID][color_id]

		if self.catDetailData then
			self.live2Dplayer:playLive2DByPath(self.catDetailData.live2D_path)
		end

		self.live2Dplayer:setSortOrder(CatRaceConfig.LOW_SORT_ORDER)
		self:refreshData()
	end
end

function ActivityCatRaceCatComp:refreshData()
	self:resetLive2Ds()

	self.isSent = self.mainActData:checkFriendIsSent(self.playerInfo.uid)

	self.giftImg:setImageGray(self.isSent)
end

function ActivityCatRaceCatComp:resetLive2Ds()
	coroutine.start(self._coResetLive2D, self)
end

function ActivityCatRaceCatComp:_coResetLive2D()
	coroutine.wait(0.1)

	if tolua.isnull(self.live2Dplayer:getComObj()) then
		return
	end

	self.live2Dplayer:playState(CatRaceConfig.CAT_RUN_STATE)
end

function ActivityCatRaceCatComp:_onBtnClose()
	self.funcAnim:startAni("CatRaceHideFunc2", true)
	self.closeBtn:setVisible(false)
	self.emptyClickPanel:setVisible(true)
end

function ActivityCatRaceCatComp:_onBtnTouch()
	self.funcAnim:startAni("CatRaceShowFunc2", true)
	self.closeBtn:setVisible(true)
	self.emptyClickPanel:setVisible(false)
end

function ActivityCatRaceCatComp:_onBtnGiftSend()
	if self.playerInfo then
		if self.mainActData:checkFriendIsSent(self.playerInfo.uid) then
			MsgManager.notice(ResClientNotice[455].notice)
		else
			local uidList = {
				self.playerInfo.uid
			}

			CurAvatar:activityRPC(Functor(RPC.opActCatRaceSendFriend, self.mainOpID, uidList), self.mainOpID)
			MsgManager.notice(ResClientNotice[450].notice)
		end
	end
end

function ActivityCatRaceCatComp:_onBtnFriendTask()
	if self.playerInfo then
		local ui = UIManager.getUI("activityCatRaceTaskDlg", true)

		if ui then
			local data = {
				mainActID = self.mainActID
			}

			ui:setData(data)
			ui:onBtnFriendTask()
		end
	end
end

function ActivityCatRaceCatComp:resetPosition(posX, posY)
	self.showEfx:playEffect()
	self.catPanel:setPosition(posX, posY)
end

return ActivityCatRaceCatComp

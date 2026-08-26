-- chunkname: @modules/logic/versionactivity2_0/dungeon/view/graffiti/VersionActivity2_0DungeonGraffitiView.lua

module("modules.logic.versionactivity2_0.dungeon.view.graffiti.VersionActivity2_0DungeonGraffitiView", package.seeall)

local VersionActivity2_0DungeonGraffitiView = class("VersionActivity2_0DungeonGraffitiView", BaseView)

function VersionActivity2_0DungeonGraffitiView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._scrollgraffiti = gohelper.findChildScrollRect(self.viewGO, "#scroll_graffiti")
	self._gograffitiContent = gohelper.findChild(self.viewGO, "#scroll_graffiti/Viewport/#go_graffitiContent")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "rewardInfo/#btn_reward")
	self._txtrewardState = gohelper.findChildText(self.viewGO, "rewardInfo/#btn_reward/#txt_rewardstate")
	self._btnrewardIcon = gohelper.findChildButtonWithAudio(self.viewGO, "rewardInfo/finalreward/#btn_rewardicon")
	self._imagerewardrare = gohelper.findChildImage(self.viewGO, "rewardInfo/finalreward/#image_rewardrare")
	self._simagerewardicon = gohelper.findChildSingleImage(self.viewGO, "rewardInfo/finalreward/#simage_rewardicon")
	self._txtrewardnum = gohelper.findChildText(self.viewGO, "rewardInfo/finalreward/#txt_rewardnum")
	self._gorewardhasget = gohelper.findChild(self.viewGO, "rewardInfo/finalreward/#go_rewardhasget")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "rewardInfo/#btn_reward/progressbar/#image_progress")
	self._txtprogress = gohelper.findChildText(self.viewGO, "rewardInfo/#btn_reward/#txt_progress")
	self._btnrightjump = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_rightjump")
	self._btnleftjump = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_leftjump")
	self._gorewardwindow = gohelper.findChild(self.viewGO, "#go_rewardwindow")
	self._gorewardReddot = gohelper.findChild(self.viewGO, "rewardInfo/#btn_reward/#go_RedDot")
	self._goCangetEffect = gohelper.findChild(self.viewGO, "rewardInfo/finalreward/#receive")
	self._goCloseRewardWindow = gohelper.findChild(self.viewGO, "#go_rewardwindow/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_0DungeonGraffitiView:addEvents()
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btnrewardIcon:AddClickListener(self._btnrewardIconOnClick, self)
	self._btnrightjump:AddClickListener(self._btnrightjumpOnClick, self)
	self._btnleftjump:AddClickListener(self._btnleftjumpOnClick, self)
	self._scrollgraffiti:AddOnValueChanged(self.refreshJumpBtnShow, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.refreshUI, self)
	self.addEventCb(self, Activity161Controller.instance, Activity161Event.RefreshGraffitiView, self.refreshUI, self)
	self.addEventCb(self, Activity161Controller.instance, Activity161Event.GetGraffitiReward, self.refreshReward, self)
end

function VersionActivity2_0DungeonGraffitiView:removeEvents()
	self._btnreward:RemoveClickListener()
	self._btnrewardIcon:RemoveClickListener()
	self._btnrightjump:RemoveClickListener()
	self._btnleftjump:RemoveClickListener()
	self._scrollgraffiti:RemoveOnValueChanged()
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.refreshUI, self)
	self.removeEventCb(self, Activity161Controller.instance, Activity161Event.RefreshGraffitiView, self.refreshUI, self)
	self.removeEventCb(self, Activity161Controller.instance, Activity161Event.GetGraffitiReward, self.refreshReward, self)
end

VersionActivity2_0DungeonGraffitiView.clickLeftJump = 0
VersionActivity2_0DungeonGraffitiView.clickRightJump = 1

function VersionActivity2_0DungeonGraffitiView:_btnrewardOnClick()
	gohelper.setActive(self._gorewardwindow, true)
	gohelper.setActive(self._goCloseRewardWindow, true)

	self.ishaveUnGetReward, self.canGetRewardList = Activity161Model.instance:ishaveUnGetReward()

	if self.ishaveUnGetReward then
		TaskDispatcher.runDelay(self.showGetRewardEffect, self, 0.5)
		UIBlockMgr.instance:startBlock("GraffitiRewardViewPlayHasGetEffect")
	end
end

function VersionActivity2_0DungeonGraffitiView:showGetRewardEffect()
	Activity161Controller.instance:dispatchEvent(Activity161Event.PlayGraffitiRewardGetAnim, self.canGetRewardList)
end

function VersionActivity2_0DungeonGraffitiView:_btnrewardIconOnClick()
	return
end

function VersionActivity2_0DungeonGraffitiView:_btnrightjumpOnClick()
	self:moveToNeedUnlockPicture(VersionActivity2_0DungeonGraffitiView.clickRightJump)
end

function VersionActivity2_0DungeonGraffitiView:_btnleftjumpOnClick()
	self:moveToNeedUnlockPicture(VersionActivity2_0DungeonGraffitiView.clickLeftJump)
end

function VersionActivity2_0DungeonGraffitiView:_editableInitView()
	gohelper.setActive(self._btnleftjump.gameObject, false)
	gohelper.setActive(self._btnrightjump.gameObject, false)

	self.screenWidth = gohelper.getUIScreenWidth()
	self._transGraffitiContent = self._gograffitiContent:GetComponent(gohelper.Type_RectTransform)
	self.scrollGraffitiRect = self._scrollgraffiti.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._contentWidth = recthelper.getWidth(self._transGraffitiContent)
	self.maxScrollPos = self._contentWidth - self.screenWidth
	self.jumpLeftElementId = 0
	self.jumpRightElementId = 0
	self.graffitiItemPath = self.viewContainer:getSetting().otherRes[1]
	self.unlockStateTab = self:getUserDataTb_()
	self.saveUnlockStateTab = self:getUserDataTb_()
	self.materialTab = self:getUserDataTb_()
	self.picturesTab = self:getUserDataTb_()

	RedDotController.instance:addRedDot(self._gorewardReddot, RedDotEnum.DotNode.V2a0GraffitiReward, Activity161Model.instance:getActId())
end

function VersionActivity2_0DungeonGraffitiView:onOpen()
	self.actId = self.viewParam.actId
	self.graffitiCount = Activity161Config.instance:getGraffitiCount(self.actId)

	self:loadGraffitiMaterial()
	self:refreshUI()
	self:refreshUnlockState()
	self:moveToFirstCanDrawGraffiti()
end

function VersionActivity2_0DungeonGraffitiView:loadGraffitiMaterial()
	local lockMaterialPath = self.viewContainer:getSetting().otherRes[2]
	local normalMaterialPath = self.viewContainer:getSetting().otherRes[3]
	local lockMaterial = self.viewContainer:getRes(lockMaterialPath)
	local normalMaterial = self.viewContainer:getRes(normalMaterialPath)

	table.insert(self.materialTab, lockMaterial)
	table.insert(self.materialTab, normalMaterial)
end

function VersionActivity2_0DungeonGraffitiView:refreshUI()
	self:initPictures()
	self:refreshReward()
	self:refreshJumpBtnShow()
end

function VersionActivity2_0DungeonGraffitiView:initPictures()
	local graffitiCoList = Activity161Config.instance.graffitiPicList

	for index, graffitiCo in pairs(graffitiCoList) do
		local pictureItem = self.picturesTab[graffitiCo.elementId]

		if not pictureItem then
			pictureItem = {
				go = gohelper.findChild(self.viewGO, "#scroll_graffiti/Viewport/#go_graffitiContent/#go_picture" .. index)
			}
			pictureItem.itemGO = self.viewContainer:getResInst(self.graffitiItemPath, pictureItem.go)
			pictureItem.item = MonoHelper.addNoUpdateLuaComOnceToGo(pictureItem.itemGO, VersionActivity2_0DungeonGraffitiItem)
			pictureItem.rect = pictureItem.go:GetComponent(gohelper.Type_RectTransform)
			pictureItem.width = recthelper.getWidth(pictureItem.rect)
			pictureItem.anchorX = recthelper.getAnchorX(pictureItem.rect)
			pictureItem.config = graffitiCo
			pictureItem.index = index
			self.picturesTab[graffitiCo.elementId] = pictureItem

			pictureItem.item:initData(self.actId, graffitiCo.elementId, self.materialTab)
		end

		pictureItem.mo = Activity161Model.instance.graffitiInfoMap[graffitiCo.elementId]
		self.unlockStateTab[graffitiCo.elementId] = Activity161Model.instance:isUnlockState(pictureItem.mo)

		pictureItem.item:refreshItem()
	end
end

function VersionActivity2_0DungeonGraffitiView:moveToNeedUnlockPicture(jumpClick)
	if jumpClick == VersionActivity2_0DungeonGraffitiView.clickRightJump then
		local pos = self.picturesTab[self.jumpRightElementId].anchorX + self.picturesTab[self.jumpRightElementId].width / 2 - self.screenWidth / 2

		pos = Mathf.Min(self.maxScrollPos, pos)

		recthelper.setAnchorX(self._transGraffitiContent, -pos)
	else
		local pos = self.picturesTab[self.jumpLeftElementId].anchorX + self.picturesTab[self.jumpLeftElementId].width / 2 - self.screenWidth / 2

		pos = Mathf.Max(0, pos)

		recthelper.setAnchorX(self._transGraffitiContent, -pos)
	end

	self.scrollGraffitiRect.velocity = Vector2(0, 0)
end

function VersionActivity2_0DungeonGraffitiView:moveToFirstCanDrawGraffiti()
	self.curCanDrawItems = Activity161Model.instance:getItemsByState(Activity161Enum.graffitiState.Normal)

	if #self.curCanDrawItems > 0 then
		local curScrollPos = self.maxScrollPos

		for i = 1, #self.curCanDrawItems do
			local elementId = self.curCanDrawItems[i].id
			local picturePos = self.picturesTab[elementId].anchorX - self.screenWidth / 2 + self.picturesTab[elementId].width / 2

			curScrollPos = Mathf.Min(curScrollPos, picturePos)
		end

		recthelper.setAnchorX(self._transGraffitiContent, -curScrollPos)
	end
end

function VersionActivity2_0DungeonGraffitiView:refreshJumpBtnShow()
	local curScrollPos = -recthelper.getAnchorX(self._transGraffitiContent)

	self.curNeedUnlockItems = Activity161Model.instance:getItemsByState(Activity161Enum.graffitiState.ToUnlock)
	self.jumpRightElementId = 0
	self.jumpLeftElementId = 0

	for i = 1, #self.curNeedUnlockItems do
		local elementId = self.curNeedUnlockItems[i].id
		local offset = self.picturesTab[elementId].anchorX - curScrollPos

		if Mathf.Abs(offset) > self.screenWidth - self.picturesTab[elementId].width / 3 and offset > 0 then
			self.jumpRightElementId = self.jumpRightElementId == 0 and elementId or Mathf.Min(self.jumpRightElementId, elementId)
		elseif Mathf.Abs(offset) > self.picturesTab[elementId].width * 2 / 3 and offset < 0 then
			self.jumpLeftElementId = self.jumpLeftElementId == 0 and elementId or Mathf.Max(self.jumpLeftElementId, elementId)
		end
	end

	gohelper.setActive(self._btnleftjump.gameObject, self.jumpLeftElementId ~= 0)
	gohelper.setActive(self._btnrightjump.gameObject, self.jumpRightElementId ~= 0)
end

function VersionActivity2_0DungeonGraffitiView:refreshReward()
	local _, finalReward = Activity161Config.instance:getFinalReward(self.actId)

	self.finalRewardType = finalReward[1]
	self.finalRewardId = finalReward[2]

	local itemConfig, icon = ItemModel.instance:getItemConfigAndIcon(self.finalRewardType, self.finalRewardId, true)

	self._simagerewardicon:LoadImage(icon)
	gohelper.setActive(self._imagerewardrare.gameObject, itemConfig.rare > 0)

	self._txtrewardnum.text = luaLang("multiple") .. finalReward[3]

	local curPaintedNum = Activity161Model.instance:getCurPaintedNum()
	local allRewardCoList = Activity161Config.instance:getAllRewardCos(self.actId)
	local allPaintNum = allRewardCoList[#allRewardCoList].paintedNum

	self._txtprogress.text = curPaintedNum == allPaintNum and string.format("<color=#fe864c>%s/%s</color>", curPaintedNum, allPaintNum) or curPaintedNum == 0 and string.format("%s/%s", curPaintedNum, allPaintNum) or string.format("<color=#fe864c>%s</color>/%s", curPaintedNum, allPaintNum)
	self._imageprogress.fillAmount = curPaintedNum / allPaintNum
	self._txtrewardState.text = Activity161Model.instance:getFinalRewardHasGetState() and luaLang("graffiti_rewardhasget") or luaLang("graffiti_rewardprogress")

	local ishaveUnGetReward = Activity161Model.instance:ishaveUnGetReward()

	gohelper.setActive(self._goCangetEffect, false)
end

function VersionActivity2_0DungeonGraffitiView:getCurRewardCanGetStage()
	local stageNum = 0
	local curFinishCount = GameUtil.getTabLen(Activity161Model.instance:getItemsByState(Activity161Enum.graffitiState.IsFinished))
	local rewardConfig = Activity161Config.instance:getAllRewardCos(self.actId)

	for index, rewardCo in pairs(rewardConfig) do
		if curFinishCount >= rewardCo.paintedNum then
			stageNum = index
		end
	end

	return stageNum
end

function VersionActivity2_0DungeonGraffitiView:refreshUnlockState()
	local saveStr = PlayerPrefsHelper.getString(self:getLocalKey(), "")

	if not string.nilorempty(saveStr) then
		for _, unlockStateStr in ipairs((cjson.decode(saveStr))) do
			local param = string.split(unlockStateStr, "|")
			local id = tonumber(param[1])

			self.saveUnlockStateTab[id] = tonumber(param[2])
		end
	end

	for elementId, pictureItem in pairs(self.picturesTab) do
		if GameUtil.getTabLen(self.saveUnlockStateTab) == 0 then
			pictureItem.item:refreshUnlockState(false)
		else
			local saveUnlockState = self.saveUnlockStateTab[elementId]

			pictureItem.item:refreshUnlockState(saveUnlockState)
		end
	end

	self:saveUnlockState()
end

function VersionActivity2_0DungeonGraffitiView:getLocalKey()
	return "DungeonGraffitiUnlock" .. "#" .. tostring(self.actId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function VersionActivity2_0DungeonGraffitiView:saveUnlockState()
	local stateSaveStrTab = {}

	for elementId, unlockState in pairs(self.unlockStateTab) do
		local saveStr = string.format("%s|%s", elementId, unlockState)

		table.insert(stateSaveStrTab, saveStr)
	end

	PlayerPrefsHelper.setString(self:getLocalKey(), cjson.encode(stateSaveStrTab))
end

function VersionActivity2_0DungeonGraffitiView:onClose()
	self:saveUnlockState()
	TaskDispatcher.cancelTask(self.showGetRewardEffect, self)
	UIBlockMgr.instance:endBlock("GraffitiRewardViewPlayHasGetEffect")

	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end
end

function VersionActivity2_0DungeonGraffitiView:onDestroyView()
	self._simagerewardicon:UnLoadImage()
end

return VersionActivity2_0DungeonGraffitiView

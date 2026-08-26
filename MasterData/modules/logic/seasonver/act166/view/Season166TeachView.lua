-- chunkname: @modules/logic/seasonver/act166/view/Season166TeachView.lua

module("modules.logic.seasonver.act166.view.Season166TeachView", package.seeall)

local Season166TeachView = class("Season166TeachView", BaseView)

function Season166TeachView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._btncloseReward = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeReward")
	self._goteachContent = gohelper.findChild(self.viewGO, "#go_teachContent")
	self._goteachItem = gohelper.findChild(self.viewGO, "#go_teachContent/#go_teachItem")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gorewardContent = gohelper.findChild(self.viewGO, "#go_rewardContent")
	self._gorewardWindow = gohelper.findChild(self.viewGO, "#go_rewardContent/#go_rewardWindow")
	self._gorewardItem = gohelper.findChild(self.viewGO, "#go_rewardContent/#go_rewardWindow/#go_rewardItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season166TeachView:addEvents()
	self._btncloseReward:AddClickListener(self._btncloseRewardOnClick, self)
end

function Season166TeachView:removeEvents()
	self._btncloseReward:RemoveClickListener()
end

function Season166TeachView:_btncloseRewardOnClick()
	for index, rewardWindow in pairs(self.rewardWindowTab) do
		gohelper.setActive(rewardWindow.window, false)

		rewardWindow.isShow = false
	end
end

function Season166TeachView:_btnRewardOnClick(teachId)
	for index, rewardWindow in pairs(self.rewardWindowTab) do
		rewardWindow.isShow = index == teachId and not rewardWindow.isShow or false

		gohelper.setActive(rewardWindow.window, rewardWindow.isShow)
	end
end

function Season166TeachView:_btnTeachItemOnClick(teachConfig)
	self:_btncloseRewardOnClick()

	local teachMO = self.Season166MO.teachInfoMap[teachConfig.teachId]
	local preTeachMO = self.Season166MO.teachInfoMap[teachConfig.preTeachId]
	local isPreFinish = teachConfig.preTeachId == 0 or teachConfig.preTeachId > 0 and preTeachMO and preTeachMO.passCount > 0

	if not teachMO or not isPreFinish then
		GameFacade.showToast(ToastEnum.Season166TeachLock)
	else
		local episodeId = teachConfig.episodeId
		local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
		local teachId = teachConfig.teachId
		local talentId = 0

		Season166TeachModel.instance:initTeachData(self.actId, teachId)
		Season166Model.instance:setBattleContext(self.actId, episodeId, nil, talentId, nil, teachId)
		DungeonFightController.instance:enterSeasonFight(episodeCo.chapterId, episodeId)
	end
end

function Season166TeachView:_editableInitView()
	self.teachItemTab = self:getUserDataTb_()
	self.rewardWindowTab = self:getUserDataTb_()
	self.localUnlockStateTab = self:getUserDataTb_()

	gohelper.setActive(self._goteachItem, false)
	gohelper.setActive(self._gorewardWindow, false)
end

function Season166TeachView:onUpdateParam()
	return
end

function Season166TeachView:onOpen()
	self.actId = self.viewParam.actId

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Season166.play_ui_shiji_tv_noise)
	self:createTeachItem()
	self:createRewardItem()
	self:refreshTeachItem()
end

function Season166TeachView:createTeachItem()
	local allTeachCoList = Season166Config.instance:getAllSeasonTeachCos()

	for index, teachConfig in ipairs(allTeachCoList) do
		local teachItem = self.teachItemTab[teachConfig.teachId]

		if not teachItem then
			teachItem = {
				config = teachConfig,
				pos = gohelper.findChild(self._goteachContent, "go_teachPos" .. index)
			}
			teachItem.item = gohelper.clone(self._goteachItem, teachItem.pos, "teachItem" .. index)
			teachItem.imageIndex = gohelper.findChildImage(teachItem.item, "title/image_index")
			teachItem.txtName = gohelper.findChildText(teachItem.item, "title/txt_name")
			teachItem.imageIcon = gohelper.findChildImage(teachItem.item, "image_icon")
			teachItem.txtDesc = gohelper.findChildText(teachItem.item, "desc/txt_desc")
			teachItem.goLock = gohelper.findChild(teachItem.item, "go_lock")
			teachItem.goFinish = gohelper.findChild(teachItem.item, "go_finish")
			teachItem.btnReward = gohelper.findChildButtonWithAudio(teachItem.item, "btn_reward")
			teachItem.btnClick = gohelper.findChildButtonWithAudio(teachItem.item, "btn_click")

			teachItem.btnReward:AddClickListener(self._btnRewardOnClick, self, teachItem.config.teachId)
			teachItem.btnClick:AddClickListener(self._btnTeachItemOnClick, self, teachItem.config)

			teachItem.anim = teachItem.item:GetComponent(gohelper.Type_Animator)
			self.teachItemTab[teachConfig.teachId] = teachItem
		end

		gohelper.setActive(teachItem.item, true)
		UISpriteSetMgr.instance:setSeason166Sprite(teachItem.imageIndex, "season_teach_num" .. index, true)

		teachItem.txtName.text = teachConfig.name
		teachItem.txtDesc.text = teachConfig.desc
	end
end

function Season166TeachView:createRewardItem()
	local allTeachCoList = Season166Config.instance:getAllSeasonTeachCos()

	for index, teachConfig in ipairs(allTeachCoList) do
		local rewardWindow = self.rewardWindowTab[teachConfig.teachId]

		if not rewardWindow then
			rewardWindow = {
				pos = gohelper.findChild(self._gorewardContent, "go_rewardPos" .. index)
			}
			rewardWindow.window = gohelper.clone(self._gorewardWindow, rewardWindow.pos, "rewardWindow" .. index)
			rewardWindow.rewardItem = gohelper.findChild(rewardWindow.window, "#go_rewardItem")
			rewardWindow.isShow = false
			rewardWindow.rewardList = self:getUserDataTb_()
			self.rewardWindowTab[teachConfig.teachId] = rewardWindow
		end

		gohelper.setActive(rewardWindow.window, true)
		gohelper.setActive(rewardWindow.rewardItem, false)

		local rewardList = string.split(teachConfig.firstBonus, "|")

		for num, rewardInfo in ipairs(rewardList) do
			local rewardItem = rewardWindow.rewardList[num]

			if not rewardItem then
				rewardItem = {
					rewardItem = gohelper.clone(rewardWindow.rewardItem, rewardWindow.window, "rewardItem" .. num)
				}
				rewardItem.itemPos = gohelper.findChild(rewardItem.rewardItem, "go_rewardItemPos")
				rewardItem.goGet = gohelper.findChild(rewardItem.rewardItem, "go_get")
				rewardItem.item = IconMgr.instance:getCommonPropItemIcon(rewardItem.itemPos)
				rewardWindow.rewardList[num] = rewardItem
			end

			gohelper.setActive(rewardItem.rewardItem, true)

			local rewardInfoList = string.splitToNumber(rewardInfo, "#")

			rewardItem.item:setMOValue(rewardInfoList[1], rewardInfoList[2], rewardInfoList[3])
			rewardItem.item:setHideLvAndBreakFlag(true)
			rewardItem.item:hideEquipLvAndBreak(true)
			rewardItem.item:setCountFontSize(51)
		end

		for num = #rewardList + 1, #rewardWindow.rewardList do
			gohelper.setActive(rewardWindow.rewardList[num].rewardItem, false)
		end
	end
end

function Season166TeachView:refreshTeachItem()
	self.Season166MO = Season166Model.instance:getActInfo(self.actId)

	local saveUnlockStateTab = Season166Model.instance:getLocalUnlockState(Season166Enum.TeachLockSaveKey)

	for teachId, teachItem in pairs(self.teachItemTab) do
		local teachConfig = teachItem.config
		local teachMO = self.Season166MO.teachInfoMap[teachConfig.teachId]
		local preTeachMO = self.Season166MO.teachInfoMap[teachConfig.preTeachId]
		local isPreFinish = teachConfig.preTeachId == 0 or teachConfig.preTeachId > 0 and preTeachMO and preTeachMO.passCount > 0
		local isLock = not teachMO or not isPreFinish
		local isFinish = teachMO and teachMO.passCount > 0

		gohelper.setActive(teachItem.goLock, isLock)
		gohelper.setActive(teachItem.goFinish, isFinish)

		local rewardWindow = self.rewardWindowTab[teachConfig.teachId]
		local rewardList = rewardWindow.rewardList

		for index, rewardItem in pairs(rewardList) do
			gohelper.setActive(rewardItem.goGet, isFinish)
		end

		gohelper.setActive(rewardWindow.window, rewardWindow.isShow)

		local iconRes = isLock and string.format("season_teach_lv%d_locked", teachId) or string.format("season_teach_lv%d", teachId)

		UISpriteSetMgr.instance:setSeason166Sprite(teachItem.imageIcon, iconRes, true)

		if isLock then
			teachItem.isLock = Season166Enum.LockState or Season166Enum.UnlockState
		end

		if not isLock and (not saveUnlockStateTab[teachId] or saveUnlockStateTab[teachId] == Season166Enum.LockState) then
			teachItem.anim:Play(UIAnimationName.Unlock, 0, 0)
		end
	end

	self:saveUnlockState()
end

function Season166TeachView:saveUnlockState()
	local saveStrTab = {}

	for teachId, teachItem in ipairs(self.teachItemTab) do
		local saveStr = string.format("%s|%s", teachId, teachItem.isLock)

		table.insert(saveStrTab, saveStr)
	end

	local saveDataStr = cjson.encode(saveStrTab)

	Season166Controller.instance:savePlayerPrefs(Season166Enum.TeachLockSaveKey, saveDataStr)
end

function Season166TeachView:onClose()
	self:saveUnlockState()
end

function Season166TeachView:onDestroyView()
	for index, teachItem in pairs(self.teachItemTab) do
		teachItem.btnReward:RemoveClickListener()
		teachItem.btnClick:RemoveClickListener()
	end
end

return Season166TeachView

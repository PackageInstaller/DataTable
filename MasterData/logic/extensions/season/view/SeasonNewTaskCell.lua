-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonNewTaskCell.lua

module("logic.extensions.season.view.SeasonNewTaskCell", package.seeall)

local M = class("SeasonNewTaskCell")
local kFinishedAlpha = 0.5

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject

	self:_buildUI()
end

function M:OnDestroy()
	self._btnGetReward:RemoveClickListener()

	self._btnGetReward = nil

	self._btnJump:RemoveClickListener()

	self._btnJump = nil

	self._btnJumpSecret:RemoveClickListener()

	self._btnJumpSecret = nil
	self._getRewardCallback = nil
	self._getRewardHandler = nil
	self._jumpCallback = nil
	self._jumpHandler = nil
end

function M:_buildUI()
	self._canvasGroup = self._mainGO:GetComponent(ComponentType.CanvasGroup)
	self._goBgProgress = goutil.findChild(self._mainGO, "img1")
	self._goBgSecret = goutil.findChild(self._mainGO, "imgDi2")
	self._goImgDay = goutil.findChild(self._mainGO, "imgDay")
	self._goImgWeek = goutil.findChild(self._mainGO, "imgWeek")
	self._goImgCycle = goutil.findChild(self._mainGO, "imgCycle")
	self._goImgSecret = goutil.findChild(self._mainGO, "imgSecret")
	self._imgProgress = goutil.findChildImageComponent(self._mainGO, "imgProgress")
	self._txtContent = goutil.findChildTextComponent(self._mainGO, "txtContent")
	self._txtProgress = goutil.findChildTextComponent(self._mainGO, "txtProgress")

	local item1 = goutil.findChild(self._mainGO, "rewardGroup/backpack_item")

	self._itemReward = Astral.SimpleLuaComponentContainer.Add(item1, ItemCell)

	self._itemReward:setShowSelectedEffect(false)

	local item2 = goutil.findChild(self._mainGO, "rewardGroup/backpack_item2")

	self._itemScore = Astral.SimpleLuaComponentContainer.Add(item2, ItemCell)

	self._itemScore:setShowSelectedEffect(false)

	self._btnJump = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGO, "btnGo"))

	self._btnJump:AddClickListener(self._onClickBtnJump, self)

	self._btnJumpSecret = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGO, "btnGo2"))

	self._btnJumpSecret:AddClickListener(self._onClickBtnJump, self)

	self._btnGetReward = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGO, "btnReceive"))

	self._btnGetReward:AddClickListener(self._onClickBtnGetReward, self)

	self._txtTips = goutil.findChildTextComponent(self._mainGO, "txtTips")

	goutil.setActive(self._txtTips.gameObject, true)

	self._goRedPoint = goutil.findChild(self._mainGO, "red_point")
	self._guiAnimation = goutil.addComponentOnce(self._mainGO, typeof(Astral.GUITimelineAniLua))
end

function M:setGetRewardCallback(callback, handler)
	self._getRewardCallback = callback
	self._getRewardHandler = handler
end

function M:setJumpCallback(callback, handler)
	self._jumpCallback = callback
	self._jumpHandler = handler
end

function M:setIndex(idx)
	self._index = idx
end

function M:setTaskData(mo)
	local inAirtightTime = AirtightRoomController.instance:getAirtightTimeInfo()
	local scoreCount = mo:getScore()

	goutil.setActive(self._itemScore._go, scoreCount > 0)

	if scoreCount > 0 then
		local itemData = ItemUtil.createItemData({
			itemId = SeasonModel.SCORE_ITEM_ID,
			count = mo:getScore()
		})

		self._itemScore:updateData(itemData)
	end

	local rewardCode, rewardNum = mo:getReward()

	if rewardCode then
		goutil.setActive(self._itemReward._go, true)

		local rewardData = ItemUtil.createItemData({
			itemId = rewardCode,
			count = rewardNum
		})

		self._itemReward:updateData(rewardData)
	else
		goutil.setActive(self._itemReward._go, false)
	end

	local curNum, totalNum = mo:getProgress()

	curNum = math.min(totalNum, curNum)
	self._txtContent.text = mo:getDesc()

	goutil.setActive(self._goRedPoint, mo:canGetReward())

	local isUnlimited = mo:getType() == SeasonEnum.TaskType.Unlimited or mo:getType() == SeasonEnum.TaskType.dayOnce
	local isWeekly = mo:getType() == SeasonEnum.TaskType.Weekly
	local isFixed = mo:getType() == SeasonEnum.TaskType.Fixed

	goutil.setActive(self._goImgDay, isUnlimited)
	goutil.setActive(self._goImgWeek, isWeekly and not mo:isSecretTask())
	goutil.setActive(self._goImgCycle, isFixed)
	goutil.setActive(self._goImgSecret, isWeekly and mo:isSecretTask())
	goutil.setActive(self._goBgSecret, isWeekly and mo:isSecretTask())
	goutil.setActive(self._imgProgress.gameObject, true)
	goutil.setActive(self._goBgProgress, true)

	self._imgProgress.fillAmount = math.min(1, curNum / totalNum)
	self._txtProgress.text = string.format("(%s/%s)", curNum, totalNum)
	self._canvasGroup.alpha = mo:isFinished() and kFinishedAlpha or 1

	if mo:isFinished() then
		goutil.setActive(self._btnGetReward.gameObject, false)
		goutil.setActive(self._btnJump.gameObject, false)
		goutil.setActive(self._btnJumpSecret.gameObject, false)
		goutil.setActive(self._txtTips.gameObject, true)

		self._txtTips.text = lang("tip_season_new_2")
	elseif mo:isActive() then
		goutil.setActive(self._btnGetReward.gameObject, true)
		goutil.setActive(self._btnJump.gameObject, false)
		goutil.setActive(self._btnJumpSecret.gameObject, false)
		goutil.setActive(self._txtTips.gameObject, false)
	elseif mo:isSecretTask() then
		goutil.setActive(self._btnGetReward.gameObject, false)
		goutil.setActive(self._btnJump.gameObject, false)

		if not inAirtightTime then
			goutil.setActive(self._btnJumpSecret.gameObject, false)
			goutil.setActive(self._txtTips.gameObject, true)

			self._txtTips.text = lang("仅密室时间开启")
		else
			goutil.setActive(self._btnJumpSecret.gameObject, mo:getJumpId() > 0)
			goutil.setActive(self._txtTips.gameObject, mo:getJumpId() <= 0)

			self._txtTips.text = lang("tip_season_new_1")
		end
	else
		goutil.setActive(self._btnGetReward.gameObject, false)
		goutil.setActive(self._btnJump.gameObject, mo:getJumpId() > 0)
		goutil.setActive(self._btnJumpSecret.gameObject, false)
		goutil.setActive(self._txtTips.gameObject, mo:getJumpId() <= 0)

		self._txtTips.text = lang("tip_season_new_1")
	end
end

function M:MoveDeltaY(deltaY, duration)
	local orgPosY = Astral.TransformUtil.GetLocalPosY(self._mainGO.transform)

	self._mainGO.transform:DOKill(false)
	self._mainGO.transform:DOLocalMoveY(orgPosY + deltaY, duration)
end

function M:setLocalPosY(y)
	Astral.TransformUtil.SetLocalPosY(self._mainGO.transform, y)
end

function M:_onClickBtnGetReward()
	self:_excuteClickReward()
end

function M:_excuteClickReward()
	if self._getRewardCallback then
		self._getRewardCallback(self._getRewardHandler, self._index)
	end
end

function M:_onClickBtnJump()
	if self._jumpCallback then
		self._jumpCallback(self._jumpHandler, self._index)
	end
end

function M:playAni(name)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName(name)
end

return M

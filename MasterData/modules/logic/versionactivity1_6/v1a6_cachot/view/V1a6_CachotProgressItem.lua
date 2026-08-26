-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotProgressItem.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotProgressItem", package.seeall)

local V1a6_CachotProgressItem = class("V1a6_CachotProgressItem", MixScrollCell)

function V1a6_CachotProgressItem:init(go)
	self._gounlock = gohelper.findChild(go, "#go_unlock")
	self._golock = gohelper.findChild(go, "#go_lock")
	self._txtscore = gohelper.findChildText(go, "#go_unlock/scorebg/#txt_score")
	self._gorewarditem = gohelper.findChild(go, "#go_unlock/#go_item/#go_rewarditem")
	self._imagepoint = gohelper.findChildImage(go, "#go_unlock/#image_point")
	self._txtlocktip = gohelper.findChildText(go, "#go_lock/#txt_locktip")
	self._txtindex = gohelper.findChildText(go, "#go_unlock/#txt_index")
	self._gospecial = gohelper.findChild(go, "#go_unlock/#go_special")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotProgressItem:addEventListeners()
	return
end

function V1a6_CachotProgressItem:removeEventListeners()
	return
end

function V1a6_CachotProgressItem:_editableInitView()
	return
end

function V1a6_CachotProgressItem:onDestroy()
	self:releaseRewardIconTab()
	TaskDispatcher.cancelTask(self.refreshUnLockNextStageTimeUI, self)
end

function V1a6_CachotProgressItem:onUpdateMO(mo, mixType, param)
	self._mo = mo

	self:refreshUI()
end

function V1a6_CachotProgressItem:refreshUI()
	gohelper.setActive(self._golock, self._mo.isLocked)
	gohelper.setActive(self._gounlock, not self._mo.isLocked)
	TaskDispatcher.cancelTask(self.refreshUnLockNextStageTimeUI, self)

	if self._mo.isLocked then
		self:onItemLocked()

		return
	end

	local scoreConfig = V1a6_CachotScoreConfig.instance:getStagePartConfig(self._mo.id)

	if scoreConfig then
		local rewardState = V1a6_CachotProgressListModel.instance:getRewardState(self._mo.id)

		self:refreshNormalUI(scoreConfig)
		self:refreshStateUI(scoreConfig, rewardState)
		self:refreshRewardItems(scoreConfig.reward, rewardState)
	end
end

function V1a6_CachotProgressItem:refreshNormalUI(scoreConfig)
	local isSpecial = scoreConfig and scoreConfig.special == 1

	gohelper.setActive(self._gospecial, isSpecial)
end

function V1a6_CachotProgressItem:onItemLocked()
	TaskDispatcher.cancelTask(self.refreshUnLockNextStageTimeUI, self)
	TaskDispatcher.runRepeat(self.refreshUnLockNextStageTimeUI, self, TimeUtil.OneMinuteSecond)
	self:refreshUnLockNextStageTimeUI()
end

function V1a6_CachotProgressItem:refreshUnLockNextStageTimeUI()
	local unLockNextStageRemainTime = V1a6_CachotProgressListModel.instance:getUnLockNextStageRemainTime()

	if unLockNextStageRemainTime and unLockNextStageRemainTime > 0 then
		local remainDay, remainHour = TimeUtil.secondsToDDHHMMSS(unLockNextStageRemainTime)

		self._txtlocktip.text = remainDay > 0 and formatLuaLang("v1a6_cachotprogressview_unlocktips_days", remainDay) or formatLuaLang("v1a6_cachotprogressview_unlocktips_hours", remainHour)
	else
		TaskDispatcher.cancelTask(self.refreshUnLockNextStageTimeUI, self)
	end
end

local finishIndexTxtColor = "#DB7D29"
local unfinishIndexTxtColor = "#FFFFFF"
local unfinishIndexTxtColorAlpha = 0.3
local finishIndexTxtColorAlpha = 0.3
local finishScroreTxtColor = "#DB7D29"
local unfinishScoreTxtColor = "#8E8E8E"

function V1a6_CachotProgressItem:refreshStateUI(scoreConfig, rewardState)
	local pointIconName = "v1a6_cachot_icon_pointdark"
	local indexTxtColor = unfinishIndexTxtColor
	local indexTxtAlpha = unfinishIndexTxtColorAlpha
	local scoreTxtColor = unfinishScoreTxtColor
	local isSpecial = scoreConfig and scoreConfig.special == 1

	if rewardState == V1a6_CachotEnum.MilestonesState.UnFinish then
		pointIconName = isSpecial and "v1a6_cachot_icon_pointdark2" or "v1a6_cachot_icon_pointdark"
	else
		pointIconName = isSpecial and "v1a6_cachot_icon_pointlight2" or "v1a6_cachot_icon_pointlight"
		indexTxtColor = finishIndexTxtColor
		indexTxtAlpha = finishIndexTxtColorAlpha
		scoreTxtColor = finishScroreTxtColor
	end

	UISpriteSetMgr.instance:setV1a6CachotSprite(self._imagepoint, pointIconName)

	self._txtscore.text = string.format("<%s>%s</color>", scoreTxtColor, scoreConfig.score)
	self._txtindex.text = self._index

	SLFramework.UGUI.GuiHelper.SetColor(self._txtindex, indexTxtColor)
	ZProj.UGUIHelper.SetColorAlpha(self._txtindex, indexTxtAlpha)
end

local HasReceiveRewardBgAlpha = 0.5
local UnReceiveRewardBgAlpha = 1
local HasReceiveRewardIconAlpha = 0.5
local UnReceiveRewardIconAlpha = 1
local HasReceiveHeadFrameAlpha = 0.5
local UnReceiveHeadFrameAlpha = 1

function V1a6_CachotProgressItem:refreshRewardItems(rewardConfig, rewardState)
	local useMap = {}

	local function iconLoadCB(item)
		local imageComp = item.simageicon.gameObject:GetComponent(typeof(UnityEngine.UI.Image))

		imageComp:SetNativeSize()
		ZProj.UGUIHelper:SetColorAlpha((rewardState == V1a6_CachotEnum.MilestonesState.HasReceived or nil) and (HasReceiveRewardIconAlpha or UnReceiveRewardIconAlpha))
	end

	if rewardConfig then
		local rewardStrList = string.split(rewardConfig, "|")

		for i = 1, #rewardStrList do
			local rewardInfo = string.splitToNumber(rewardStrList[i], "#")
			local item = self:getOrCreateRewardItem(i)

			self:refreshSingleRewardItem(item, rewardInfo, rewardState, iconLoadCB)

			useMap[item] = true
		end
	end

	self:recycleUnUseRewardItem(useMap)
end

function V1a6_CachotProgressItem:getOrCreateRewardItem(index)
	self._rewardItemTab = self._rewardItemTab or {}

	local rewardItem = self._rewardItemTab[index]

	if not rewardItem then
		rewardItem = self:getUserDataTb_()
		rewardItem.go = gohelper.cloneInPlace(self._gorewarditem, "reward_" .. index)
		rewardItem.imagebg = gohelper.findChildImage(rewardItem.go, "bg")
		rewardItem.simageicon = gohelper.findChildSingleImage(rewardItem.go, "simage_reward")
		rewardItem.goheadframe = gohelper.findChild(rewardItem.go, "go_headframe")
		rewardItem.frameCanvasGroup = gohelper.onceAddComponent(rewardItem.goheadframe, typeof(UnityEngine.CanvasGroup))
		rewardItem.gocanget = gohelper.findChild(rewardItem.go, "go_canget")
		rewardItem.gohasget = gohelper.findChild(rewardItem.go, "go_hasget")
		rewardItem.txtrewardcount = gohelper.findChildText(rewardItem.go, "txt_rewardcount")
		rewardItem.btnclick = gohelper.findChildButtonWithAudio(rewardItem.go, "btn_click")
		self._rewardItemTab[index] = rewardItem
	end

	return rewardItem
end

function V1a6_CachotProgressItem:refreshSingleRewardItem(item, rewardInfo, rewardState, iconLoadCB)
	local materialType = rewardInfo and rewardInfo[1]
	local materialId = rewardInfo and rewardInfo[2]
	local materialCount = rewardInfo and rewardInfo[3]
	local itemCfg, iconPath = ItemModel.instance:getItemConfigAndIcon(materialType, materialId)

	UISpriteSetMgr.instance:setV1a6CachotSprite(item.imagebg, "v1a6_cachot_img_quality_" .. itemCfg.rare)
	ZProj.UGUIHelper.SetColorAlpha(item.imagebg, (rewardState == V1a6_CachotEnum.MilestonesState.HasReceived or nil) and (HasReceiveRewardBgAlpha or UnReceiveRewardBgAlpha))
	gohelper.setActive(item.goheadframe, false)
	gohelper.setActive(item.txtrewardcount, true)

	if materialType == MaterialEnum.MaterialType.Equip then
		item.simageicon:LoadImage(ResUrl.getHeroDefaultEquipIcon(itemCfg.icon), iconLoadCB, item)
	elseif itemCfg.subType == ItemEnum.SubType.Portrait then
		if rewardState == V1a6_CachotEnum.MilestonesState.HasReceived then
			if not HasReceiveHeadFrameAlpha then
				local headAlpha = UnReceiveHeadFrameAlpha

				self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(item.simageicon)

				self._liveHeadIcon:setLiveHead(tonumber(itemCfg.icon), true, nil, function(self, liveIcon)
					liveIcon:setAlpha(headAlpha)
				end, self)
				gohelper.setActive(item.goheadframe, true)
				gohelper.setActive(item.txtrewardcount, false)

				item.frameCanvasGroup.alpha = headAlpha
			end
		end
	else
		item.simageicon:LoadImage(iconPath, iconLoadCB, item)
	end

	item.txtrewardcount.text = formatLuaLang("cachotprogressview_rewardcount", materialCount)

	gohelper.setActive(item.gohasget, rewardState == V1a6_CachotEnum.MilestonesState.HasReceived)
	gohelper.setActive(item.gocanget, rewardState == V1a6_CachotEnum.MilestonesState.CanReceive)
	gohelper.setActive(item.go, true)
	item.btnclick:RemoveClickListener()
	item.btnclick:AddClickListener(self.onClickRewardItem, self, rewardInfo)
end

function V1a6_CachotProgressItem:onClickRewardItem(itemCfg)
	local state = V1a6_CachotProgressListModel.instance:getRewardState(self._mo.id)

	if state == V1a6_CachotEnum.MilestonesState.CanReceive then
		local canReceiveRewardList = V1a6_CachotProgressListModel.instance:getCanReceivePartIdList()

		RogueRpc.instance:sendGetRogueScoreRewardRequest(V1a6_CachotEnum.ActivityId, canReceiveRewardList)
	elseif itemCfg then
		MaterialTipController.instance:showMaterialInfo(itemCfg[1], itemCfg[2])
	end
end

function V1a6_CachotProgressItem:recycleUnUseRewardItem(useMap)
	if useMap and self._rewardItemTab then
		for _, v in pairs(self._rewardItemTab) do
			if not useMap[v] then
				gohelper.setActive(v.go, false)
			end
		end
	end
end

function V1a6_CachotProgressItem:releaseRewardIconTab()
	if self._rewardItemTab then
		for k, v in pairs(self._rewardItemTab) do
			if v.btnclick then
				v.btnclick:RemoveClickListener()
			end

			if v.simageicon then
				v.simageicon:UnLoadImage()
			end
		end
	end
end

return V1a6_CachotProgressItem

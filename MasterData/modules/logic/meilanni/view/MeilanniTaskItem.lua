-- chunkname: @modules/logic/meilanni/view/MeilanniTaskItem.lua

module("modules.logic.meilanni.view.MeilanniTaskItem", package.seeall)

local MeilanniTaskItem = class("MeilanniTaskItem", ListScrollCellExtend)

function MeilanniTaskItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_bg")
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_normal/#go_rewards")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#go_normal/#go_rewards/#go_rewarditem")
	self._gonotget = gohelper.findChild(self.viewGO, "#go_normal/#go_notget")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#go_notget/#btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#go_notget/#btn_finishbg")
	self._goblackmask = gohelper.findChild(self.viewGO, "#go_normal/#go_blackmask")
	self._goget = gohelper.findChild(self.viewGO, "#go_normal/#go_get")
	self._imagelevelbg = gohelper.findChildImage(self.viewGO, "#go_normal/#image_levelbg")
	self._simagelevel = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_level")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._simagegetallbg = gohelper.findChildSingleImage(self.viewGO, "#go_getall/#simage_getallbg")
	self._btncollectall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/go_getall/#btn_collectall")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MeilanniTaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	self._btncollectall:AddClickListener(self._btncollectallOnClick, self)
end

function MeilanniTaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	self._btncollectall:RemoveClickListener()
end

function MeilanniTaskItem:_btncollectallOnClick()
	self:_collect()
end

function MeilanniTaskItem:_btnnotfinishbgOnClick()
	local mapId = self._mo.mapId
	local mapConfig = lua_activity108_map.configDict[mapId]
	local isLock = MeilanniMapItem.isLock(mapConfig)

	if isLock then
		GameFacade.showToast(ToastEnum.MeilanniTask)

		return
	end

	MeilanniMapItem.gotoMap(mapId)
end

function MeilanniTaskItem:_btnfinishbgOnClick()
	self:_collect()
end

function MeilanniTaskItem:_collect()
	self.animatorPlayer = self._mo.isGetAll and ZProj.ProjAnimatorPlayer.Get(self._gogetall) or ZProj.ProjAnimatorPlayer.Get(self._gonormal)
	self._animator.speed = 1

	self.animatorPlayer:Play("finish", self.onFinishFirstPartAnimationDone, self)
end

function MeilanniTaskItem:onFinishFirstPartAnimationDone()
	self._view.viewContainer.taskAnimRemoveItem:removeByIndex(self._index, self.onFinishSecondPartAnimationDone, self)
end

function MeilanniTaskItem:onFinishSecondPartAnimationDone()
	Activity108Rpc.instance:sendGet108BonusRequest(MeilanniEnum.activityId, self._mo.id)
end

function MeilanniTaskItem:_editableInitView()
	self._rewardItems = self:getUserDataTb_()

	self._simagegetallbg:LoadImage(ResUrl.getMeilanniIcon("bg_rwdi_1"))
	self._simagebg:LoadImage(ResUrl.getMeilanniIcon("bg_rwdi_2"))
end

function MeilanniTaskItem:_editableAddEvents()
	gohelper.addUIClickAudio(self._btnnotfinishbg.gameObject, AudioEnum.Meilanni.play_ui_mln_move)
	gohelper.addUIClickAudio(self._btnfinishbg.gameObject, AudioEnum.Meilanni.play_ui_mln_receive)
	gohelper.addUIClickAudio(self._btncollectall.gameObject, AudioEnum.Meilanni.play_ui_mln_receive)
end

function MeilanniTaskItem:_editableRemoveEvents()
	return
end

function MeilanniTaskItem:onUpdateMO(mo)
	self._mo = mo
	self._canGet = false

	gohelper.setActive(self._gonormal, not mo.isGetAll)
	gohelper.setActive(self._gogetall, mo.isGetAll)

	if mo.isGetAll then
		self._canGet = true
		self._animator = self._gogetall:GetComponent(typeof(UnityEngine.Animator))

		return
	end

	self._animator = self._gonormal:GetComponent(typeof(UnityEngine.Animator))
	self._txttaskdes.text = mo.desc

	local mapInfo = MeilanniModel.instance:getMapInfo(mo.mapId)
	local curScore = mapInfo and mapInfo:getMaxScore() or 0
	local totalScore = mo.score
	local isGet = mapInfo and mapInfo:isGetReward(self._mo.id)

	gohelper.setActive(self._gonotget, not isGet)
	gohelper.setActive(self._goget, isGet)
	gohelper.setActive(self._goblackmask, isGet)

	if not isGet then
		local isFinish = totalScore <= curScore

		gohelper.setActive(self._btnnotfinishbg.gameObject, not isFinish)
		gohelper.setActive(self._btnfinishbg.gameObject, isFinish)

		self._canGet = isFinish
	end

	local scoreIndex = MeilanniConfig.instance:getScoreIndex(mo.score)

	if isGet or self._canGet then
		self._simagelevel:LoadImage(ResUrl.getMeilanniLangIcon("bg_jiangli_pingfen_" .. scoreIndex))
	else
		self._simagelevel:LoadImage(ResUrl.getMeilanniLangIcon("bg_jiangli_pingfen_" .. scoreIndex .. "_dis"))
	end

	self:_addRewards()
end

function MeilanniTaskItem:_addRewards()
	self._rewardItems = self._rewardItems or self:getUserDataTb_()

	local rewards = string.split(self._mo.bonus, "|")

	for i = 1, #rewards do
		local itemCo = string.splitToNumber(rewards[i], "#")

		self:_showItem(i, itemCo)
	end
end

function MeilanniTaskItem:_showItem(index, itemCo)
	local item = self._rewardItems[index]

	if not item then
		item = {
			parentGo = gohelper.cloneInPlace(self._gorewarditem)
		}

		gohelper.setActive(item.parentGo, true)

		item.itemIcon = IconMgr.instance:getCommonPropItemIcon(item.parentGo)

		item.itemIcon:isShowCount(itemCo[1] ~= MaterialEnum.MaterialType.Hero)
		item.itemIcon:showStackableNum2()
		item.itemIcon:setHideLvAndBreakFlag(true)
		item.itemIcon:hideEquipLvAndBreak(true)

		self._rewardItems[index] = item
	end

	item.itemIcon:setMOValue(itemCo[1], itemCo[2], itemCo[3], nil, true)
	item.itemIcon:setCountFontSize(40)
end

function MeilanniTaskItem:onSelect(isSelect)
	return
end

function MeilanniTaskItem:onDestroyView()
	for _, v in pairs(self._rewardItems) do
		gohelper.destroy(v.itemIcon.go)
		gohelper.destroy(v.parentGo)
		v.itemIcon:onDestroy()
	end

	self._rewardItems = nil

	self._simagebg:UnLoadImage()
	self._simagegetallbg:UnLoadImage()
end

function MeilanniTaskItem:getAnimator()
	return self._animator
end

return MeilanniTaskItem

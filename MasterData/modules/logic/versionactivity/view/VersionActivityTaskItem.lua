-- chunkname: @modules/logic/versionactivity/view/VersionActivityTaskItem.lua

module("modules.logic.versionactivity.view.VersionActivityTaskItem", package.seeall)

local VersionActivityTaskItem = class("VersionActivityTaskItem", ListScrollCell)

VersionActivityTaskItem.episodeColor = "#C05216"

function VersionActivityTaskItem:init(go)
	self.viewGO = go
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_bg")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_normal/info/#txt_desc")
	self._gomode = gohelper.findChild(self.viewGO, "#go_normal/info/#go_mode")
	self._gostorymode1 = gohelper.findChild(self.viewGO, "#go_normal/info/#go_mode/#go_storymode1")
	self._gostorymode2 = gohelper.findChild(self.viewGO, "#go_normal/info/#go_mode/#go_storymode2")
	self._gostorymode3 = gohelper.findChild(self.viewGO, "#go_normal/info/#go_mode/#go_storymode3")
	self._gohardmode = gohelper.findChild(self.viewGO, "#go_normal/info/#go_mode/#go_hardmode")
	self._txtremaindesc = gohelper.findChildText(self.viewGO, "#go_normal/info/#txt_remaindesc")
	self._txtpointcount = gohelper.findChildText(self.viewGO, "#go_normal/#txt_pointcount")
	self._txtcurprogress = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_curprogress")
	self._txttotalprogress = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_totalprogress")
	self._imagefull = gohelper.findChildImage(self.viewGO, "#go_normal/progress/probarbg/#image_full")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_jump")
	self._btnreceive = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_receive")
	self._btnhasgot = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_hasgot")
	self._gofinishmask = gohelper.findChild(self.viewGO, "#go_normal/#go_finishmask")
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._simagegetallbg = gohelper.findChildSingleImage(self._gogetall, "bg")
	self._btngetall = gohelper.findChildButtonWithAudio(self._gogetall, "#btn_getall")
	self._txtrewardcount = gohelper.findChildText(self._gogetall, "#txt_pointcount")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityTaskItem:addEventListeners()
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
	self._btnreceive:AddClickListener(self._btnreceiveOnClick, self)
	self._btnhasgot:AddClickListener(self._btnhasgotOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
end

function VersionActivityTaskItem:removeEventListeners()
	self._btnjump:RemoveClickListener()
	self._btnreceive:RemoveClickListener()
	self._btnhasgot:RemoveClickListener()
	self._btngetall:RemoveClickListener()
end

function VersionActivityTaskItem:_btnjumpOnClick()
	if self.co.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if GameFacade.jump(self.co.jumpId) then
			ViewMgr.instance:closeView(ViewName.VersionActivityTaskView)
		end
	end
end

function VersionActivityTaskItem:_btnhasgotOnClick()
	return
end

function VersionActivityTaskItem:_btngetallOnClick()
	self:_btnreceiveOnClick()
end

VersionActivityTaskItem.FinishAnimationBlockKey = "FinishAnimationBlockKey"

function VersionActivityTaskItem:_btnreceiveOnClick()
	self.animatorPlayer = self.taskMo.getAll and ZProj.ProjAnimatorPlayer.Get(self._gogetall) or ZProj.ProjAnimatorPlayer.Get(self._gonormal)

	gohelper.setActive(self._gofinishmask, true)

	self._animator.speed = 1

	UIBlockMgr.instance:startBlock(VersionActivityTaskItem.FinishAnimationBlockKey)
	self.animatorPlayer:Play("finish", self.onFinishFirstPartAnimationDone, self)
end

function VersionActivityTaskItem:onFinishFirstPartAnimationDone()
	self._view.viewContainer.taskAnimRemoveItem:removeByIndex(self._index, self.onFinishSecondPartAnimationDone, self)
end

function VersionActivityTaskItem:onFinishSecondPartAnimationDone()
	VersionActivityTaskBonusListModel.instance:recordPrefixActivityPointCount()

	if self.taskMo.getAll then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.ActivityDungeon, nil, nil, self.onReceiveReply, self, VersionActivityEnum.ActivityId.Act113)
	else
		TaskRpc.instance:sendFinishTaskRequest(self.co.id, self.onReceiveReply, self)
	end

	UIBlockMgr.instance:endBlock(VersionActivityTaskItem.FinishAnimationBlockKey)
end

function VersionActivityTaskItem:onReceiveReply(cmd, resultCode, msg)
	if resultCode == 0 then
		VersionActivityController.instance:dispatchEvent(VersionActivityEvent.OnReceiveFinishTaskReply)
	end
end

function VersionActivityTaskItem:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getVersionActivityIcon("img_di2"))
end

function VersionActivityTaskItem:onUpdateMO(taskMo)
	self.taskMo = taskMo

	gohelper.setActive(self._gonormal, not self.taskMo.getAll)
	gohelper.setActive(self._gogetall, self.taskMo.getAll)

	if self.taskMo.getAll then
		self:refreshGetAllUI()

		self._animator = self._gogetall:GetComponent(typeof(UnityEngine.Animator))
	else
		self:refreshNormalUI()

		self._animator = self._gonormal:GetComponent(typeof(UnityEngine.Animator))
	end
end

function VersionActivityTaskItem:refreshNormalUI()
	self.co = self.taskMo.config

	self:refreshDesc()

	self._txtpointcount.text = luaLang("multiple") .. self.co.activity
	self._txtcurprogress.text = self.taskMo.progress
	self._txttotalprogress.text = self.co.maxProgress
	self._imagefull.fillAmount = self.taskMo.progress / self.co.maxProgress

	if self.taskMo.finishCount >= self.co.maxFinishCount then
		gohelper.setActive(self._btnjump.gameObject, false)
		gohelper.setActive(self._btnreceive.gameObject, false)
		gohelper.setActive(self._btnhasgot.gameObject, true)
		gohelper.setActive(self._gofinishmask, true)
	elseif self.taskMo.hasFinished then
		gohelper.setActive(self._btnreceive.gameObject, true)
		gohelper.setActive(self._btnjump.gameObject, false)
		gohelper.setActive(self._btnhasgot.gameObject, false)
		gohelper.setActive(self._gofinishmask, false)
	else
		gohelper.setActive(self._btnjump.gameObject, true)
		gohelper.setActive(self._btnreceive.gameObject, false)
		gohelper.setActive(self._btnhasgot.gameObject, false)
		gohelper.setActive(self._gofinishmask, false)
	end
end

function VersionActivityTaskItem:refreshDesc()
	local globalDesc = self.co.desc
	local prefixDesc, mode, suffixDesc = string.match(globalDesc, "(.-)%[(.-)%](.+)")
	local hasMode = false

	if mode then
		self:clearModeStatus()

		if mode == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Story1]) then
			gohelper.setActive(self._gostorymode1, true)

			hasMode = true
		elseif mode == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Story2]) then
			gohelper.setActive(self._gostorymode2, true)

			hasMode = true
		elseif mode == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Story3]) then
			gohelper.setActive(self._gostorymode3, true)

			hasMode = true
		elseif mode == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Hard]) then
			gohelper.setActive(self._gohardmode, true)

			hasMode = true
		end
	end

	prefixDesc = prefixDesc or self.co.desc
	prefixDesc = string.gsub(prefixDesc, "(TRC%-%d+)", "<color=#C05216>%1</color>")
	self._txtdesc.text = prefixDesc

	gohelper.setActive(self._gomode, hasMode)

	self._txtremaindesc.text = hasMode and suffixDesc or ""
end

function VersionActivityTaskItem:refreshGetAllUI()
	self._simagegetallbg:LoadImage(ResUrl.getVersionActivityIcon("xuanzhong"))

	self._txtrewardcount.text = string.format("<size=30>X</size>%s", VersionActivityTaskListModel.instance:getFinishTaskActivityCount())
end

function VersionActivityTaskItem:canGetReward()
	return self.taskMo.finishCount < self.co.maxFinishCount and self.taskMo.hasFinished
end

function VersionActivityTaskItem:getAnimator()
	return self._animator
end

function VersionActivityTaskItem:clearModeStatus()
	gohelper.setActive(self._gostorymode1, false)
	gohelper.setActive(self._gostorymode2, false)
	gohelper.setActive(self._gostorymode3, false)
	gohelper.setActive(self._gohardmode, false)
end

function VersionActivityTaskItem:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagegetallbg:UnLoadImage()

	if self.animatorPlayer then
		self.animatorPlayer:Stop()
	end
end

return VersionActivityTaskItem

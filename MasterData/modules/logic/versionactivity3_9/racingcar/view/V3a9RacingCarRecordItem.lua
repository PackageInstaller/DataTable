-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/V3a9RacingCarRecordItem.lua

module("modules.logic.versionactivity3_9.racingcar.view.V3a9RacingCarRecordItem", package.seeall)

local V3a9RacingCarRecordItem = class("V3a9RacingCarRecordItem", ListScrollCellExtend)

function V3a9RacingCarRecordItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._simagenormalbg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_normalbg")
	self._txtresult1 = gohelper.findChildText(self.viewGO, "#go_normal/#simage_normalbg/#txt_result1")
	self._gogrey = gohelper.findChild(self.viewGO, "#go_normal/#simage_normalbg/#go_grey")
	self._simageplayerbg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_playerbg")
	self._txtresult2 = gohelper.findChildText(self.viewGO, "#go_normal/#simage_playerbg/#txt_result2")
	self._imagecolor = gohelper.findChildImage(self.viewGO, "#go_normal/rank/#image_color")
	self._imagerole = gohelper.findChildImage(self.viewGO, "#go_normal/rank/#image_role")
	self._imagerank = gohelper.findChildImage(self.viewGO, "#go_normal/rank/#image_rank")
	self._txtteam = gohelper.findChildText(self.viewGO, "#go_normal/#txt_team")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_normal/#txt_name")
	self._txtunfinished = gohelper.findChildText(self.viewGO, "#go_normal/#txt_unfinished")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9RacingCarRecordItem:addEvents()
	return
end

function V3a9RacingCarRecordItem:removeEvents()
	return
end

function V3a9RacingCarRecordItem:_editableInitView()
	self._canvasGroup = self.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._rectMask2D = self._gonormal:GetComponent(gohelper.Type_RectMask2D)
	self._goRankBg = gohelper.findChild(self.viewGO, "#go_normal/rank/rankbg")
end

function V3a9RacingCarRecordItem:_editableAddEvents()
	return
end

function V3a9RacingCarRecordItem:_editableRemoveEvents()
	return
end

function V3a9RacingCarRecordItem:onUpdateMO(mo)
	if not mo then
		return
	end

	local racerConfig = mo.racerConfig

	self._txtname.text = racerConfig.name
	self._txtteam.text = racerConfig.team

	gohelper.setActive(self._simagenormalbg, not mo.isPlayer)
	gohelper.setActive(self._simageplayerbg, mo.isPlayer)
	gohelper.setActive(self._goRankBg, mo.rank == 1)

	local time = mo.time

	if time <= 0 then
		gohelper.setActive(self._txtunfinished, true)

		self._txtunfinished.text = luaLang("v3a9Racing_car_unfinished")
	end

	local timeStr = self:_formatTime(time)

	self._txtresult1.text = timeStr
	self._txtresult2.text = timeStr

	UISpriteSetMgr.instance:setV3a9RacingSprite(self._imagerank, "v3a9_racing_game_rank" .. mo.rank)

	local icon = "v3a9_racing_game_character_end_" .. racerConfig.pic

	UISpriteSetMgr.instance:setV3a9RacingSprite(self._imagerole, icon)
end

function V3a9RacingCarRecordItem:setRankData(rank, racerData)
	racerData.rank = rank

	self:onUpdateMO(racerData)

	self._canvasGroup.alpha = 0

	TaskDispatcher.cancelTask(self._delayShow, self)
	TaskDispatcher.runDelay(self._delayShow, self, 0.6 + (rank - 1) * 0.09)
	UISpriteSetMgr.instance:setV3a9RacingSprite(self._imagecolor, "v3a9_racing_playerbg_1_" .. rank)

	local isFourth = rank == 4

	recthelper.setAnchorY(self._gonormal.transform, isFourth and 10 or 0)
	recthelper.setAnchorY(self._imagerole.transform, isFourth and 16 or 0)

	self._rectMask2D.enabled = isFourth

	gohelper.setActive(self._gogrey, isFourth)
end

function V3a9RacingCarRecordItem:_delayShow()
	self._canvasGroup.alpha = 1

	local animator = self.viewGO:GetComponent("Animator")

	animator:Play("open", 0, 0)
end

function V3a9RacingCarRecordItem:_formatTime(seconds)
	if seconds <= 0 then
		return ""
	end

	local mins = math.floor(seconds / 60)
	local secs = math.floor(seconds % 60)
	local ms = math.floor(seconds % 1 * 100)

	return string.format("%02d:%02d:%02d", mins, secs, ms)
end

function V3a9RacingCarRecordItem:onSelect(isSelect)
	return
end

function V3a9RacingCarRecordItem:onDestroyView()
	TaskDispatcher.cancelTask(self._delayShow, self)
end

return V3a9RacingCarRecordItem

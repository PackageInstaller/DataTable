-- chunkname: @modules/logic/room/view/critter/summon/RoomCritterSummonPoolIcon.lua

module("modules.logic.room.view.critter.summon.RoomCritterSummonPoolIcon", package.seeall)

local RoomCritterSummonPoolIcon = class("RoomCritterSummonPoolIcon", CommonCritterIcon)

function RoomCritterSummonPoolIcon:onInitView()
	self._imagequality = gohelper.findChildImage(self.viewGO, "#simage_quality")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")
	self._gomood = gohelper.findChild(self.viewGO, "#go_mood")
	self._gohasMood = gohelper.findChild(self.viewGO, "#go_mood/#go_hasMood")
	self._simagemood = gohelper.findChildSingleImage(self.viewGO, "#go_mood/#go_hasMood/#simage_mood")
	self._simageprogress = gohelper.findChildSingleImage(self.viewGO, "#go_mood/#go_hasMood/#simage_progress")
	self._txtmood = gohelper.findChildText(self.viewGO, "#go_mood/#go_hasMood/#txt_mood")
	self._gonoMood = gohelper.findChild(self.viewGO, "#go_mood/#go_noMood")
	self._gobuildingIcon = gohelper.findChild(self.viewGO, "#go_buildingIcon")
	self._simagebuildingIcon = gohelper.findChildSingleImage(self.viewGO, "#go_buildingIcon/#simage_buildingIcon")
	self._goindex = gohelper.findChild(self.viewGO, "#go_index")
	self._txtindex = gohelper.findChildText(self.viewGO, "#go_index/#txt_index")
	self._gonum = gohelper.findChild(self.viewGO, "#go_num")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_num/#txt_num")
	self._gofinish = gohelper.findChild(self.viewGO, "#go_finish")
	self._btnclick = gohelper.findChildClickWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterSummonPoolIcon:onUpdateMO(mo)
	self.mo = mo

	self:setMOValue()
	self:activeGo()
end

function RoomCritterSummonPoolIcon:setMOValue(critterUid, critterId, isShowSelectUI, index)
	self.critterId = self.mo.critterId

	self:setSelectUIVisible(isShowSelectUI)
	self:refresh()
end

function RoomCritterSummonPoolIcon:refresh()
	RoomCritterSummonPoolIcon.super.refresh(self)
	self:refrshNum()
	self:refrshNull()
end

function RoomCritterSummonPoolIcon:refreshIcon()
	local skinId = self.mo:getCritterMo():getSkinId()
	local iconName = CritterConfig.instance:getCritterHeadIcon(skinId)

	if not string.nilorempty(iconName) then
		local iconPath = ResUrl.getCritterHedaIcon(iconName)

		self:_loadIcon(iconPath)
	end
end

function RoomCritterSummonPoolIcon:activeGo()
	gohelper.setActive(self._gomood, false)
	gohelper.setActive(self._goindex, false)
	gohelper.setActive(self._gonum, true)
end

function RoomCritterSummonPoolIcon:refrshNum()
	self._txtnum.text = self.mo:getPoolCount()
end

function RoomCritterSummonPoolIcon:refrshNull()
	local isFinish = self.mo:getPoolCount() <= 0

	gohelper.setActive(self._gofinish, isFinish)
	ZProj.UGUIHelper.SetGrayscale(self._imagequality.gameObject, isFinish)
	ZProj.UGUIHelper.SetGrayscale(self._simageicon.gameObject, isFinish)
end

return RoomCritterSummonPoolIcon

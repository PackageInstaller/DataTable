-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/view/BattleRecordViewItem.lua

module("logic.extensions.battlerecord.view.BattleRecordViewItem", package.seeall)

local BattleRecordViewItem = class("BattleRecordViewItem", UIReusableLuaBehavior)
local kType2Des = {
	[BattleExtension_pb.BattleType.DUNGEON] = "副本战斗",
	[BattleExtension_pb.BattleType.GM_CUSTOMIZE] = "GM自定义",
	[BattleExtension_pb.BattleType.GM_LEVEL] = "GM关卡",
	[BattleExtension_pb.BattleType.PVP] = "PVP",
	[BattleExtension_pb.BattleType.RODEO_AIR] = "空气工坊竞技模式",
	[BattleExtension_pb.BattleType.TEST_AIR] = "空气工坊测试",
	[BattleExtension_pb.BattleType.FREE_AIR] = "空气工坊自由模式",
	[BattleExtension_pb.BattleType.ENDLESS_AIR] = "空气工坊无尽模式"
}

function BattleRecordViewItem:buildUI()
	self._txtContent = goutil.findChildTextComponent(self.mainGO, "Text")
	self._btnClick = Astral.ButtonAdapter.Get(self.mainGO)

	self._btnClick:AddClickListener(self._onClickIcon, self)

	self._handler = false
	self._recordMO = false
end

function BattleRecordViewItem:destroyUI()
	self._btnClick:RemoveClickListener()

	self._btnClick = nil
	self._txtContent = nil
	self._handler = nil
	self._recordMO = nil
end

local sb = StringBuffer.New()

function BattleRecordViewItem:setRecordMO(recordMO)
	self._recordMO = recordMO

	sb:append(string.format("编号:%s [%s]", recordMO.recordId, kType2Des[recordMO.recordType]))
	sb:appendLine()
	sb:append(string.format("时间:%s", TimeUtil.instance:stampToDateStr(recordMO.timestamp)))
	sb:appendLine()

	if recordMO.recordType == BattleExtension_pb.BattleType.DUNGEON then
		sb:append(string.format("副本:%s", recordMO.passId))
	elseif recordMO.recordType == BattleExtension_pb.BattleType.PVP then
		sb:append(string.format("角色:%s", BattleTableUtil.arrayToString(recordMO.relatedUserIds)))
	else
		sb:append("Unknown")
	end

	self._txtContent.text = sb:toString()

	sb:clear()
end

function BattleRecordViewItem:setHandler(handler)
	self._handler = handler
end

function BattleRecordViewItem:_onClickIcon()
	self._handler:onClickRecordItem(self._recordMO)
end

return BattleRecordViewItem

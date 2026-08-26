-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_SettlementScoreItem.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_SettlementScoreItem", package.seeall)

local Rouge2_SettlementScoreItem = class("Rouge2_SettlementScoreItem", LuaCompBase)

function Rouge2_SettlementScoreItem:init(go)
	self.go = go
	self._imageicon = gohelper.findChildImage(self.go, "#image_icon")
	self._txtnum = gohelper.findChildText(self.go, "#txt_num")
	self._txtname = gohelper.findChildText(self.go, "#txt_name")
	self._txtscore = gohelper.findChildText(self.go, "#txt_score")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_SettlementScoreItem:_editableInitView()
	return
end

function Rouge2_SettlementScoreItem:setInfo(info, index)
	local constId = Rouge2_Enum.OutSideConstId.SettleScoreIcon
	local constConfig = Rouge2_OutSideConfig.instance:getConstConfigById(constId)
	local param = string.splitToNumber(constConfig.value, "#")

	Rouge2_IconHelper.setRougeEventIcon2(param[index], self._imageicon)

	self._txtscore.text = info.score and tostring(info.score) or ""
	self._txtnum.text = info.num and tostring(info.num) or ""
	self._txtname.text = luaLang("rouge2_settlement_score_title_" .. index)
end

function Rouge2_SettlementScoreItem:onDestroy()
	return
end

return Rouge2_SettlementScoreItem

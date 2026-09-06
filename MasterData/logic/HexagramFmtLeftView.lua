-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yirenpozhen/view/fmtview/HexagramFmtLeftView.lua

module("logic.extensions.yirenpozhen.view.fmtview.HexagramFmtLeftView", package.seeall)

local HexagramFmtLeftView = class("HexagramFmtLeftView", FormationLeftView)

function HexagramFmtLeftView:onEnter()
	HexagramFmtLeftView.super.onEnter(self)
	self:_setActiveBtnFormation(false)
	self:setBtnCutePetActive(false)
	self:_setActiveBtnFormationUse(false)
end

function HexagramFmtLeftView:onExit()
	HexagramFmtLeftView.super.onExit(self)
end

function HexagramFmtLeftView:_onSelectBuffForm(formId, formLv)
	formLv = checknumber(formLv)
	formId = checknumber(formId)

	if formId > 0 then
		formLv = BattleConfig.instance:getFormStrengthMaxLv(formId)
	end

	BFMissionLeftView.super._onSelectBuffForm(self, formId, formLv)
end

function HexagramFmtLeftView:GetFormStrengthIdAndLv()
	local fid = 0
	local flvl = 0
	local info = self:_getCurFormation():GetFormStrengthInfo()

	if info and info.formStrengthId and info.formStrengthId > 0 then
		fid = info.formStrengthId
		flvl = info.formStrengthLv
	end

	return fid, (fid > 0 or nil) and BattleConfig.instance:getFormStrengthMaxLv(fid)
end

function HexagramFmtLeftView:_OnClickBtnBuffForm()
	HexagramFmtLeftView.super._OnClickBtnBuffForm(self)
	TipsFacade.instance:openCommonTips(lang("本玩法中,已经解锁的阵法生效后自动设置为<color=#00ff00>满级</color>"))
end

function HexagramFmtLeftView:_getCurFormId()
	return 0
end

function HexagramFmtLeftView:_getPet(id)
	return YirenPozhenController.instance:getTempMaxPet(id)
end

function HexagramFmtLeftView:_getItemSeatCls()
	return BFMissionItemSeat
end

function HexagramFmtLeftView:_getCurrTeamId()
	return 1
end

function HexagramFmtLeftView:_saveCurrFmt()
	return
end

return HexagramFmtLeftView

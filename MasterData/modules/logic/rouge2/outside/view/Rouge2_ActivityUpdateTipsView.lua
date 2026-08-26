-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_ActivityUpdateTipsView.lua

module("modules.logic.rouge2.outside.view.Rouge2_ActivityUpdateTipsView", package.seeall)

local Rouge2_ActivityUpdateTipsView = class("Rouge2_ActivityUpdateTipsView", BaseView)

function Rouge2_ActivityUpdateTipsView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._goUpdateList = gohelper.findChild(self.viewGO, "#go_Root/#scroll_Desc/Viewport/Content")
	self._goUpdateItem = gohelper.findChild(self.viewGO, "#go_Root/#scroll_Desc/Viewport/Content/#go_UpdateItem")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_ActivityUpdateTipsView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function Rouge2_ActivityUpdateTipsView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function Rouge2_ActivityUpdateTipsView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_ActivityUpdateTipsView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
end

function Rouge2_ActivityUpdateTipsView:onOpen()
	self:refreshUI()
end

function Rouge2_ActivityUpdateTipsView:refreshUI()
	local updateTipsCo = Rouge2_OutSideConfig.instance:getConstConfigById(Rouge2_Enum.OutSideConstId.ActivityUpdateTips)

	if updateTipsCo then
		if not updateTipsCo.desc then
			local updateTipsStr = ""
			local updateTipsList = GameUtil.splitString2(updateTipsStr, false, "|", "@") or {}

			gohelper.CreateObjList(self, self._refreshUpdateItem, updateTipsList, self._goUpdateList, self._goUpdateItem)
		end
	end
end

function Rouge2_ActivityUpdateTipsView:_refreshUpdateItem(goUpdateItem, tipsList, index)
	local goSubTipsList = gohelper.findChild(goUpdateItem, "go_SubTipsList")
	local goSubTipsItem = gohelper.findChild(goUpdateItem, "go_SubTipsList/go_SubTipsItem")
	local txtMiniTitle = gohelper.findChildText(goUpdateItem, "Header/txt_MiniTitle")

	txtMiniTitle.text = table.remove(tipsList, 1)

	gohelper.CreateObjList(self, self._refreshSubTipsItem, tipsList, goSubTipsList, goSubTipsItem)
end

function Rouge2_ActivityUpdateTipsView:_refreshSubTipsItem(goSubTipsItem, subTips, index)
	local txtSubTips = gohelper.findChildText(goSubTipsItem, "txt_SubTips")

	txtSubTips.text = SkillHelper.buildDesc(subTips)

	SkillHelper.addHyperLinkClick(txtSubTips)
end

function Rouge2_ActivityUpdateTipsView:onClose()
	self:closeThis()
end

function Rouge2_ActivityUpdateTipsView:onDestroyView()
	return
end

return Rouge2_ActivityUpdateTipsView

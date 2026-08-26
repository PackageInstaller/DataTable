-- chunkname: @modules/logic/survival/view/rewardinherit/SurvivalRewardInheritNpcSelectComp.lua

module("modules.logic.survival.view.rewardinherit.SurvivalRewardInheritNpcSelectComp", package.seeall)

local SurvivalRewardInheritNpcSelectComp = class("SurvivalRewardInheritNpcSelectComp", LuaCompBase)

function SurvivalRewardInheritNpcSelectComp:ctor(param)
	self.parentView = param.parentView
	self.refreshFunc = param.refreshFunc
	self.npcItem = {}
end

function SurvivalRewardInheritNpcSelectComp:init(go)
	self.go = go
	self._txttips = gohelper.findChildText(go, "layout/#txt_tips")
	self._gogrid1 = gohelper.findChild(go, "layout/#go_grid1")
	self._goitem1 = gohelper.findChild(go, "layout/#go_grid1/#go_item1")
	self._goitem2 = gohelper.findChild(go, "layout/#go_grid1/#go_item2")
	self._gogrid2 = gohelper.findChild(go, "layout/#go_grid2")
	self._goitem3 = gohelper.findChild(go, "layout/#go_grid2/#go_item3")
	self._goitem4 = gohelper.findChild(go, "layout/#go_grid2/#go_item4")
	self.itemPos = {
		self._goitem1,
		self._goitem3,
		self._goitem4
	}

	for i, v in ipairs(self.itemPos) do
		gohelper.setActive(v, false)
	end

	self.npcSelectMo = SurvivalRewardInheritModel.instance.npcSelectMo
end

function SurvivalRewardInheritNpcSelectComp:refreshInheritSelect(isFirst, readyPos)
	gohelper.setActive(self._gogrid1, true)
	gohelper.setActive(self._gogrid2, self.npcSelectMo.maxAmount > 2)

	for pos = 1, self.npcSelectMo.maxAmount do
		if self.npcItem[pos] == nil then
			local resPath = self.parentView.viewContainer:getSetting().otherRes.survivalnpcheaditem
			local item = self.parentView:getResInst(resPath, self.itemPos[pos])

			gohelper.setActive(self.itemPos[pos], true)

			self.npcItem[pos] = MonoHelper.addNoUpdateLuaComOnceToGo(item, SurvivalNpcHeadItem)
		end

		local npcId
		local id = self.npcSelectMo.selectIdDic[pos]

		if id then
			local mo = SurvivalHandbookModel.instance:getMoById(id)

			npcId = mo:getCellCfgId()
		end

		local isSelect = pos == readyPos

		self.npcItem[pos]:setData({
			isShowBtnRemove = true,
			isPlayPutEffect = true,
			isFirst = isFirst,
			pos = pos,
			npcId = npcId,
			onClickContext = self,
			onClickBtnRemoveCallBack = self.onClickBtnRemoveCallBack,
			isSelect = isSelect
		})
	end
end

function SurvivalRewardInheritNpcSelectComp:onClickBtnRemoveCallBack(survivalNpcHeadItem)
	local pos = survivalNpcHeadItem.pos

	self.npcSelectMo:removeOneByPos(pos)
	self.refreshFunc(self.parentView)
end

return SurvivalRewardInheritNpcSelectComp

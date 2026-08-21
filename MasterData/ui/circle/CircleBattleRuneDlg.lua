-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleRuneDlg.lua

local CircleBattleRuneCell = require("UI/Circle/CircleBattleRuneCell")
local ResClanBattleRune = require("ClientData/ResClanBattleRune")
local ResClanBattleLayer = require("ClientData/ResClanBattleLayer")
local strClassName = "CircleBattleRuneDlg"
local CircleBattleRuneDlg = Class(strClassName, UIControls.Window)

function CircleBattleRuneDlg:ctor()
	self:initUI()
end

function CircleBattleRuneDlg:initUI()
	self.txtDes = UIControls.Label(self, "Bg/TextTitle/TextDes")
	self.txtTips = UIControls.Label(self, "Bg/TextTips")
	self.cells = {}
	self.scrollRune = UIControls.ScrollView(self, "Bg/RuneList")
	self.panelSubTitle = UIControls.Panel(self, "Bg/TextSubTitle")
	self.txtNone = UIControls.Label(self, "Bg/TextNone")

	self:initRuneList()
end

function CircleBattleRuneDlg:initRuneList()
	if CurAvatar.myCircle then
		self.txtNone:setText(ClientUtils.getClientNotice(592))

		self.runeDataList = CurAvatar.myCircle:getRuneDataList()
		self.combineRuneDataList = CurAvatar.myCircle:getCombineRuneDataList()

		if #self.combineRuneDataList > 0 then
			self.runeCells = {}

			self.panelSubTitle:setVisible(true)
			self.txtNone:setVisible(false)
			self.scrollRune:setVisible(true)

			for idx, runeData in ipairs(self.combineRuneDataList) do
				local runeCell = CircleBattleRuneCell(self, "Bg/RuneList/Content", "System/CircleBattle/CircleBattleRuneCell", 0, 0, true)

				runeCell:setRune(self.combineRuneDataList[idx])
				table.insert(self.runeCells, runeCell)
			end
		else
			self.panelSubTitle:setVisible(false)
			self.scrollRune:setVisible(false)
			self.txtNone:setVisible(true)
		end

		local curBattleLayerConfig = CurAvatar.myCircle:getCurBattleLayerConfig()

		if curBattleLayerConfig then
			self.txtDes:setText(utils.format(Lang.get(40574), #self.runeDataList, curBattleLayerConfig.rune_num))
		end
	end
end

return CircleBattleRuneDlg

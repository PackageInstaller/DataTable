-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeHallowChooseDlg.lua

local ResRelics = require("ClientData/ResRelics")
local strClassName = "MazeHallowChooseDlg"
local ICON_PATH = "Atlas/MazeAtlas/MazeAtlas5"
local MazeHallowChooseDlg = Class(strClassName, UIControls.Window)

function MazeHallowChooseDlg:ctor(...)
	self:initUI()
end

function MazeHallowChooseDlg:initUI(...)
	self.btnHoldOn = UIControls.Button(self, "BgPanel/BtnHoldOn")

	self.btnHoldOn:addEventClick(self.onBtnHoldOnClick)

	self.uiHallows = {}

	for i = 1, 3 do
		local btn = UIControls.Button(self, "BgPanel/BtnHallow" .. i, "TextHallowName")

		btn.icon = UIControls.Image(self, "BgPanel/BtnHallow" .. i .. "/Icon")
		btn.desc = UIControls.Label(self, "BgPanel/BtnHallow" .. i .. "/TextHallowEffect")
		btn.imgConditions = {}
		btn.panelCondition = UIControls.Panel(self, "BgPanel/BtnHallow" .. i .. "/BgCondition")

		for j = 1, 3 do
			local imgCondition = UIControls.Image(self, "BgPanel/BtnHallow" .. i .. "/BgCondition/Condition" .. j)

			table.insert(btn.imgConditions, imgCondition)
		end

		btn.mIndex = i

		table.insert(self.uiHallows, btn)
		btn:addEventClick(self.onBtnHallowClick)
	end

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm", "Text")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.selectBtn = nil
end

function MazeHallowChooseDlg:show(relics)
	if #CurAvatar.mazeData.relics_node > 0 then
		if #CurAvatar.mazeData.relics_node == 1 then
			self.btnConfirm:setText(string.format(Lang.get(30574), #CurAvatar.mazeData.relics_node))
		else
			self.btnConfirm:setText(string.format(Lang.get(30575), #CurAvatar.mazeData.relics_node))
		end
	end

	self.selectBtn = nil

	for i, data in ipairs(relics) do
		if ResRelics[data.id] then
			local resRelic = ResRelics[data.id]
			local hallow = self.uiHallows[i]

			hallow:setEnable(true)
			hallow:setText(resRelic.name)
			hallow.desc:setText(resRelic.dec)

			if resRelic.camp_id then
				hallow:setImage(ICON_PATH, "BgBuffGroup" .. resRelic.camp_id)
			else
				hallow:setImage(ICON_PATH, "BgBuff")
			end

			hallow.icon:setImage(resRelic.relic_icon_path, resRelic.relic_icon_name)

			if resRelic.icon_path and resRelic.icon_name then
				hallow.panelCondition:setVisible(true)

				local names = utils.splitString(resRelic.icon_name, ",")

				if names then
					local idx = 0

					for _, name in ipairs(names) do
						idx = idx + 1

						hallow.imgConditions[idx]:setImage(resRelic.icon_path, name)
						hallow.imgConditions[idx]:setVisible(true)
					end

					for i = idx + 1, #hallow.imgConditions do
						hallow.imgConditions[i]:setVisible(false)
					end
				end
			else
				hallow.panelCondition:setVisible(false)
			end
		end
	end
end

function MazeHallowChooseDlg:onBtnHoldOnClick(...)
	CurAvatar.mazeChooseHallowLater = true

	self:setVisible(false)
end

function MazeHallowChooseDlg:onBtnConfirmClick(...)
	if self.selectBtn then
		if #CurAvatar.mazeData.relics_node > 0 then
			local data = CurAvatar.mazeData.relics_node[1]

			RPC.mazeSelectSweepRelics(data.layer, data.node_id, self.selectBtn.mIndex)

			if #CurAvatar.mazeData.relics_node <= 1 then
				self:setVisible(false)
			end
		else
			RPC.mazeSelectRelics(self.selectBtn.mIndex)
			self:setVisible(false)
		end

		MsgManager.notice(string.format(Lang.get(30576), self.selectBtn:getText()))

		CurAvatar.mazeChooseHallowLater = false
	else
		MsgManager.notice(Lang.get(30577))
	end
end

function MazeHallowChooseDlg:onBtnHallowClick(sender)
	for i, btn in ipairs(self.uiHallows) do
		if i == sender.mIndex then
			self.uiHallows[i]:setEnable(false)

			self.selectBtn = self.uiHallows[i]
		else
			self.uiHallows[i]:setEnable(true)
		end
	end
end

return MazeHallowChooseDlg

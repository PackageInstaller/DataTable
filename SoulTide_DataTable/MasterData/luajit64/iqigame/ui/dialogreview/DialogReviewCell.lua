-- chunkname: @IQIGame\\UI\\DialogReview\\DialogReviewCell.lua

local m = {}

function m.PackageOrReuseView(ui, cellGo)
	if ui == nil or cellGo == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_DialogReviewCell == nil then
		ui.__SUB_UI_MAP_DialogReviewCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_DialogReviewCell
	local cell

	if subUIMap[cellGo:GetInstanceID()] == nil then
		cell = m.New(cellGo)
		subUIMap[cellGo:GetInstanceID()] = cell
	else
		cell = subUIMap[cellGo:GetInstanceID()]
	end

	return cell
end

function m.DisposeIn(ui)
	if ui.__SUB_UI_MAP_DialogReviewCell == nil then
		return
	end

	for i, cell in pairs(ui.__SUB_UI_MAP_DialogReviewCell) do
		cell:Dispose()
	end

	ui.__SUB_UI_MAP_DialogReviewCell = nil
end

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(dialogCid)
	local cfgDialogData = CfgDialogTable[dialogCid]
	local speakerName
	local npcCid = cfgDialogData.Player[cfgDialogData.CurrentPlayer]

	if npcCid ~= nil and npcCid ~= 0 then
		local cfgNpcData = CfgNPCTable[npcCid]

		speakerName = cfgNpcData.Name
	else
		speakerName = ""
	end

	self.SpeakerNameBg:SetActive(npcCid ~= nil and npcCid ~= 0)

	self.SpeakerNameText:GetComponent("Text").text = DialogReviewUIApi:GetString("SpeakerName", speakerName)

	local content = self:GetFinalText(cfgDialogData.Contents)

	self.ContentText:GetComponent("Text").text = DialogReviewUIApi:GetString("ContentText", content)
end

function m:GetFinalText(contents)
	local text = ""

	for i = 1, #contents do
		local content

		if PlayerModule.PlayerInfo.baseInfo.pName ~= nil then
			content = string.gsub(contents[i], "{PlayerName}", PlayerModule.PlayerInfo.baseInfo.pName)
		else
			content = contents[i]
		end

		text = text .. content
	end

	return text
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m

-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HeroCVNamePanel.lua

local strClassName = "HeroCVNamePanel"
local HeroCVNamePanel = Class(strClassName, UIControls.Panel)

function HeroCVNamePanel:ctor()
	self:initUI()
end

function HeroCVNamePanel:initUI()
	self.panelCvName = UIControls.Panel(self, self.mPath .. "")
	self.txtCvNameList = {}

	for i = 1, 2 do
		local cvName = UIControls.Label(self, self.mPath .. "/TxtPanel/TxtName" .. i)

		table.insert(self.txtCvNameList, cvName)
	end

	self.txtLog = UIControls.Label(self, self.mPath .. "/TxtPanel/TxtLog")
end

function HeroCVNamePanel:setHero(hero)
	self.hero = hero

	self.panelCvName:setVisible(false)

	if Const.CV_LIST and #Const.CV_LIST > 0 then
		local cvNameList = {}

		for _, field_id in ipairs(Const.CV_LIST) do
			if self.hero.resData[Const.CV_ID_FIELD_DIC[field_id]] then
				local nakeName = self.hero.resData[Const.CV_ID_FIELD_DIC[field_id]] or ""
				local cvName = nakeName

				if #Const.CV_LIST > 1 then
					cvName = cvName .. "(" .. Const.CV_ID_DESC_DIC[field_id] .. ")"
				end

				table.insert(cvNameList, cvName)
			end
		end

		if #cvNameList == 0 then
			for field_id, propName in ipairs(Const.CV_ID_FIELD_DIC) do
				if self.hero.resData[propName] then
					local nakeName = self.hero.resData[propName] or ""
					local cvName = nakeName

					cvName = cvName .. "(" .. Const.CV_ID_DESC_DIC[field_id] .. ")"

					table.insert(cvNameList, cvName)
				end
			end
		end

		self.panelCvName:setVisible(#cvNameList >= 1)
		self.txtLog:setVisible(#cvNameList >= 2)

		for i, txtCvName in ipairs(self.txtCvNameList) do
			if cvNameList[i] then
				txtCvName:setVisible(true)
				txtCvName:setText(cvNameList[i])
			else
				txtCvName:setVisible(false)
			end
		end
	end
end

return HeroCVNamePanel

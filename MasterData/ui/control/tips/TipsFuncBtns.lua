-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Tips\\TipsFuncBtns.lua

local strClassName = "TipsFuncBtns"
local TipsFuncBtns = Class(strClassName, UIControls.Panel)

function TipsFuncBtns:ctor(parent, path, maxCount, otherCount)
	self._maxBaseCount = maxCount or 2
	self._maxOtherCount = otherCount or 0

	self:initUI()
	self:clear()
end

function TipsFuncBtns:initUI()
	self.btnBases = {}

	for i = 1, self._maxBaseCount do
		local btn

		if UIControls.checkControlFunc(self, self.mPath .. "/BtnFunc" .. i) then
			btn = UIControls.Button(self, self.mPath .. "/BtnFunc" .. i, "Text")
		elseif UIControls.checkControlFunc(self, self.mPath .. "/FuncPanel/BtnFunc" .. i) then
			btn = UIControls.Button(self, self.mPath .. "/FuncPanel/BtnFunc" .. i, "Text")
		end

		btn:addEventClick(self.onBtnClick)
		table.insert(self.btnBases, btn)
	end

	self.btnOthers = {}

	if UIControls.checkControlFunc(self, self.mPath .. "/MoreContent") then
		self.content = UIControls.Panel(self, self.mPath .. "/MoreContent")

		for i = 1, self._maxOtherCount do
			if UIControls.checkControlFunc(self, self.mPath .. "/MoreContent/BtnFunc" .. i) then
				local btn = UIControls.Button(self, self.mPath .. "/MoreContent/BtnFunc" .. i, "Text")

				btn:addEventClick(self.onBtnClick)
				table.insert(self.btnOthers, btn)
			end
		end
	end
end

function TipsFuncBtns:clear()
	self._needMore = false
	self._targetSender = nil

	for i, btn in ipairs(self.btnBases) do
		btn.info = nil
	end

	for i, btn in ipairs(self.btnOthers) do
		btn.info = nil
	end

	if self.content then
		self.content:setVisible(false)
	end

	self:setVisible(false)
end

function TipsFuncBtns:setConfig(infos, sender)
	self._targetSender = sender
	self._needMore = false

	local btns = {}

	if self._needMore then
		local btn = self.btnBases[self._maxBaseCount]

		btn:setText(Lang.get(984))

		btn.info = nil

		for i = 1, self._maxBaseCount - 1 do
			table.insert(btns, self.btnBases[i])
		end

		for _, btnOther in ipairs(self.btnOthers) do
			table.insert(btns, btnOther)
		end
	else
		btns = self.btnBases
	end

	for i, btn in ipairs(btns) do
		btn:setVisible(false)
	end

	local usedBtn = {}

	for i, info in ipairs(infos) do
		if not usedBtn[info.idx] then
			local btn = btns[info.idx]

			btn.info = info

			local visible = true

			if info.visible then
				visible = info.visible(info.ui, sender)
			else
				visible = true
			end

			if visible then
				usedBtn[info.idx] = true
			end

			btn:setVisible(visible)
			btn:setText(info.name)

			local enable = true

			if info.enable ~= nil then
				enable = info.enable(info.ui, sender)
			end

			btn:setEnable(enable)
		end
	end

	self:setVisible(#infos ~= 0)
end

function TipsFuncBtns:onBtnClick(sender)
	if self._needMore and sender == self.btnBases[self._maxBaseCount] then
		self.content:changeVisible()
	elseif sender.info ~= nil then
		local result = sender.info.use(sender.info.ui, self._targetSender)

		if result ~= true then
			self:clear()
			self.mWindow:setVisible(false)
		end
	end
end

return TipsFuncBtns

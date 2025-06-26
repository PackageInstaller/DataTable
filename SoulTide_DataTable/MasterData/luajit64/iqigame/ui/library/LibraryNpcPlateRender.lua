-- chunkname: @IQIGame\\UI\\Library\\LibraryNpcPlateRender.lua

local LibraryNpcPlateRender = {}

function LibraryNpcPlateRender.New(view)
	local obj = Clone(LibraryNpcPlateRender)

	obj:Init(view)

	return obj
end

function LibraryNpcPlateRender:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function LibraryNpcPlateRender.SortEvent(tb1, tb2)
	local aIsRead = tb1.isLock == true and 1 or 0
	local bIsRead = tb2.isLock == true and 1 or 0

	return bIsRead < aIsRead
end

function LibraryNpcPlateRender:SetData(title, data)
	UGUIUtil.SetText(self.TextTitle, title)
	table.sort(data, LibraryNpcPlateRender.SortEvent)

	local index = 0

	for i, v in pairs(data) do
		index = index + 1

		local text = self["Text" .. index]

		if text then
			if v.isLock == false then
				UGUIUtil.SetText(text, LibraryNpcListUIApi:GetString("TextDefault"))
			else
				UGUIUtil.SetText(text, v.Describe)
			end
		end
	end
end

function LibraryNpcPlateRender:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return LibraryNpcPlateRender

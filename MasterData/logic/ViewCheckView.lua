-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/viewcheck/view/ViewCheckView.lua

module("logic.extensions.viewcheck.view.ViewCheckView", package.seeall)

local ViewCheckView = class("ViewCheckView", TableViewComponent)

function ViewCheckView:_getPath()
	return {
		cellPath = "sv_item",
		viewPath = "sv_info"
	}
end

function ViewCheckView:_cellSize()
	return 1500, 230
end

function ViewCheckView:SetColorTag(record_value, limit_value)
	if not record_value or not limit_value then
		return
	end

	return (record_value and limit_value < record_value or nil) and Color.red
end

function ViewCheckView:_updateCell(view, cell, data)
	local tex_view_name_value = goutil.findChildComponent(cell.gameObject, "bk/tex_view_name/tex_view_name_value", "Text")

	tex_view_name_value.text = data.view_name

	local tex_view_load_time_value = {}
	local tex_view_load_time_value_sum = 0
	local tex_view_load_time_value_cnt = 0

	for i = 1, 5 do
		tex_view_load_time_value[i] = goutil.findChildComponent(cell.gameObject, "bk/tex_view_load_time/tex_view_load_time_value_" .. i, "Text")
		tex_view_load_time_value[i].text = ""

		if i < 5 and data.record_time and data.record_time[i] then
			tex_view_load_time_value[i].text = data.record_time[i] .. "ms"
			tex_view_load_time_value[i].color = self:SetColorTag(data.record_time[i], 300)
			tex_view_load_time_value_sum = tex_view_load_time_value_sum + data.record_time[i]
			tex_view_load_time_value_cnt = tex_view_load_time_value_cnt + 1
		end
	end

	local tex_view_load_time_value_avg = math.ceil(tex_view_load_time_value_sum / tex_view_load_time_value_cnt)

	tex_view_load_time_value[5].text = tex_view_load_time_value_avg .. "ms"
	tex_view_load_time_value[5].color = self:SetColorTag(tex_view_load_time_value_avg, 300)

	local tex_view_resload_time_value = {}
	local tex_view_resload_time_value_sum = 0
	local tex_view_resload_time_value_cnt = 0

	for i = 1, 5 do
		tex_view_resload_time_value[i] = goutil.findChildComponent(cell.gameObject, "bk/tex_view_resload_time/tex_view_resload_time_value_" .. i, "Text")
		tex_view_resload_time_value[i].text = ""

		if i < 5 and data.res_load_record_time and data.res_load_record_time[i] then
			tex_view_resload_time_value[i].text = data.res_load_record_time[i] .. "ms"
			tex_view_resload_time_value[i].color = self:SetColorTag(data.res_load_record_time[i], 300)
			tex_view_resload_time_value_sum = tex_view_resload_time_value_sum + data.res_load_record_time[i]
			tex_view_resload_time_value_cnt = tex_view_resload_time_value_cnt + 1
		end
	end

	local tex_view_resload_time_value_avg = math.ceil(tex_view_resload_time_value_sum / tex_view_resload_time_value_cnt)

	tex_view_resload_time_value[5].text = tex_view_resload_time_value_avg .. "ms"
	tex_view_resload_time_value[5].color = self:SetColorTag(tex_view_resload_time_value_avg, 300)

	local tex_view_logic_time_value = {}
	local tex_view_logic_time_value_sum = 0
	local tex_view_logic_time_value_cnt = 0

	for i = 1, 5 do
		tex_color = Color.black
		tex_view_logic_time_value[i] = goutil.findChildComponent(cell.gameObject, "bk/tex_view_logic_time/tex_view_logic_time_value_" .. i, "Text")
		tex_view_logic_time_value[i].text = ""

		if i < 5 and data.res_load_record_time and data.record_time[i] and data.res_load_record_time[i] then
			local logic_time = data.record_time[i] - data.res_load_record_time[i]

			tex_view_logic_time_value[i].text = logic_time .. "ms" or ""
			tex_view_logic_time_value[i].color = self:SetColorTag(logic_time, 100)
			tex_view_logic_time_value_sum = tex_view_logic_time_value_sum + logic_time
			tex_view_logic_time_value_cnt = tex_view_logic_time_value_cnt + 1
		end
	end

	local tex_view_logic_time_value_avg = math.ceil(tex_view_logic_time_value_sum / tex_view_logic_time_value_cnt)

	tex_view_logic_time_value[5].text = tex_view_logic_time_value_avg .. "ms"
	tex_view_logic_time_value[5].color = self:SetColorTag(tex_view_logic_time_value_avg, 100)

	local tex_view_instance_time_value = {}
	local tex_view_instance_time_value_sum = 0
	local tex_view_instance_time_value_cnt = 0

	for i = 1, 5 do
		tex_color = Color.black
		tex_view_instance_time_value[i] = goutil.findChildComponent(cell.gameObject, "bk/tex_view_instance_time/tex_view_instance_time_value_" .. i, "Text")
		tex_view_instance_time_value[i].text = ""

		if i < 5 and data.instance_time and data.instance_time[i] then
			tex_view_instance_time_value[i].text = data.instance_time[i] .. "ms"
			tex_view_instance_time_value[i].color = self:SetColorTag(data.instance_time[i], 50)
			tex_view_instance_time_value_sum = tex_view_instance_time_value_sum + data.instance_time[i]
			tex_view_instance_time_value_cnt = tex_view_instance_time_value_cnt + 1
		end
	end

	local tex_view_instance_time_value_avg = math.ceil(tex_view_instance_time_value_sum / tex_view_instance_time_value_cnt)

	tex_view_instance_time_value[5].text = tex_view_instance_time_value_avg .. "ms"
	tex_view_instance_time_value[5].color = self:SetColorTag(tex_view_instance_time_value_avg, 50)

	local tex_view_res = goutil.findChildComponent(cell.gameObject, "bk/tex_view_res", "Text")

	tex_view_res.gameObject:SetActive(false)

	local tex_view_res_value = goutil.findChildComponent(cell.gameObject, "bk/tex_view_res/tex_view_res_value", "Text")
end

function ViewCheckView:ctor()
	ViewCheckView.super.ctor(self)
end

function ViewCheckView:buildUI()
	ViewCheckView.super.buildUI(self)

	self.sv_info = self:getGo("sv_info")

	local pos = self.sv_info.transform.localPosition

	pos.x = -553
	pos.y = 323

	uGuiUtil.setLocalPosition(self.sv_info, pos)

	self._closeButton = self:getBtn("bg/btn_close")
end

function ViewCheckView:bindEvents()
	ViewCheckView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function ViewCheckView:_onClickClose()
	UIStateManager.instance:pop()
	ResGcMgr.instance:gc()
end

function ViewCheckView:unbindEvents()
	ViewCheckView.super.unbindEvents(self)
end

function ViewCheckView:destroyUI()
	ViewCheckView.super.destroyUI(self)
end

function ViewCheckView:onEnter()
	ViewCheckView.super.onEnter(self)

	self._curViewDatas = ViewCheck.instance:getViewOpenTimeRecord()

	self._tableview:ReloadData()
end

function ViewCheckView:onEnterFinished()
	ViewCheckView.super.onEnterFinished(self)
end

function ViewCheckView:onExit()
	ViewCheckView.super.onExit(self)

	self._curViewDatas = nil
end

function ViewCheckView:onExitFinished()
	ViewCheckView.super.onExitFinished(self)
end

return ViewCheckView

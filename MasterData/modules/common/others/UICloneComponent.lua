-- chunkname: @modules/common/others/UICloneComponent.lua

module("modules.common.others.UICloneComponent", package.seeall)

local UICloneComponent = class("UICloneComponent", UserDataDispose)

function UICloneComponent:ctor()
	self:__onInit()

	self.create_data = self:getUserDataTb_()
end

function UICloneComponent:createObjList(class, callback, data, parent_obj, model_obj, component, delay_time, create_count)
	if type(data) == "number" then
		local num = data

		data = {}

		for i = 1, num do
			table.insert(data, i)
		end
	end

	if not parent_obj then
		logError("没有传入格子父节点")

		return
	end

	if not model_obj then
		logError("没有传入格子模型")

		return
	end

	if delay_time then
		local tab = self:getUserDataTb_()

		tab.total_num = #data
		tab.delay_time = delay_time or 0.01
		tab.create_count = create_count or 1
		tab.cur_count = 0
		tab.class = class
		tab.callback = callback
		tab.data = data
		tab.parent_obj = parent_obj
		tab.model_obj = model_obj
		tab.component = component
		tab.start_time = Time.realtimeSinceStartup

		table.insert(self.create_data, tab)
		TaskDispatcher.runRepeat(self._detectCloneState, self, 0.01)
	else
		gohelper.CreateObjList(class, callback, data, parent_obj, model_obj, component)
	end
end

function UICloneComponent:_detectCloneState()
	for i, v in ipairs(self.create_data) do
		if Time.realtimeSinceStartup - v.start_time >= v.delay_time then
			v.start_time = Time.realtimeSinceStartup

			if v.cur_count < v.total_num then
				local start_index = v.cur_count + 1

				v.cur_count = v.cur_count + v.create_count

				if v.cur_count > v.total_num then
					v.cur_count = v.total_num
				end

				local end_index = v.cur_count

				gohelper.CreateObjList(v.class, v.callback, v.data, v.parent_obj, v.model_obj, v.component, start_index, end_index)
			end
		end
	end

	for i = #self.create_data, 1, -1 do
		local data = self.create_data[i]

		if data.cur_count >= data.total_num then
			table.remove(self.create_data, i)
		end
	end

	if #self.create_data == 0 then
		TaskDispatcher.cancelTask(self._detectCloneState, self)
	end
end

function UICloneComponent:releaseSelf()
	TaskDispatcher.cancelTask(self._detectCloneState, self)
	self:__onDispose()
end

return UICloneComponent

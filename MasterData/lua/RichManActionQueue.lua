local this = {}

function this.New(playerCtrl)
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	this.actions={};
	this.playerCtrl=playerCtrl;--用户控制器
	this.currentAction=nil;
	return tab
end

--添加事件
function this:AddAction(action)
	if action~=nil then
		table.insert(self.actions,action);
		self.isDone=false;
	end
end

--添加事件到最前面
function this:AddActionFront(action)
	if action~=nil then
		table.insert(self.actions,1,action);
		self.isDone=false;
	end
end

function this:Clean()
	if self.currentAction and self.currentAction:IsDone()~=true then
		self.currentAction:Stop();
	end
	self.actions={};
	self.currentAction=nil;
	self.playerCtrl=nil;
	self.isDone=true;
end

--队列播放动作更新
function this:Update()
	if not self.currentAction and #self.actions>0 then
		self.currentAction=table.remove(self.actions,1);
		self.currentAction:Enter(self.playerCtrl);
		self.isDone=false;
	end

	if self.currentAction then
		self.currentAction:Update(self.playerCtrl);	
		if self.currentAction:IsDone() then
			self.currentAction=nil;
			if self.actions==nil or #self.actions==0  then
				self.isDone=true;
			end
		end
	end
end

function this:GetCount()
	return self.actions~=nil and #self.actions or 0;
end

function this:IsDone()
	return self.isDone;
end

return this;
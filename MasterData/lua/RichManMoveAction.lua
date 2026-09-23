local this = oo.class(RichManActionBase)

function this:Enter(playerCtrl)
    -- 执行移动逻辑
    playerCtrl.PlayMove(true);
	self.speed=self.data.isAuto and 5.5 or 3.5;--自动状态下移动速度更快
	self.playIdx=1;
	-- LogError("RichManMoveAction------------------------------>Enter"..tostring(self.data.mapData:GetID()));
	--播放当前位置的格子图标渐显效果
	EventMgr.Dispatch(EventType.RichMan_GridIcon_Alpha,{pos=self.data.startGrid:GetPos(),isHide=false})
	EventMgr.Dispatch(EventType.RichMan_Set_TargetEff,{grids=self.data.grids,isShow=true})
	EventMgr.Dispatch(EventType.RichMan_MoveAction_State,true)
	-- LogError("RichManMoveAction------------------------------>Enter"..tostring(self.data.mapData:GetID()));
	-- for k,v in ipairs(self.data.grids) do
	-- 	LogError(tostring(v:GetSort()))
	-- end
	self:SetState(1);
	self.sendPress=false;
end

function this:Update(playerCtrl)
    if RichManActionBase:Update(playerCtrl) then
        do
            return
        end
    end
	local pos = playerCtrl.gameObject.transform.position;
    if self.targetPos==nil and self.playIdx<=#self.data.grids then	
		self.currGrid=self.data.grids[self.playIdx];
		-- LogError(tostring(self.curGridPos).."\t"..tostring(self.playIdx).."\t"..tostring(self.currGrid:GetID().."\t"..tostring(self.currGrid:GetPos())))
		-- LogError("移动至ID:"..tostring(self.currGrid:GetID()).."的格子");
		self.targetGO,self.targetGrid=playerCtrl.GetGridGO(self.currGrid:GetPos());
		self.targetPos=self.targetGO.transform.position;
		local dir2=self.targetPos-pos;
		self.moveDirection=dir2.normalized;
		self.playIdx=self.playIdx+1;
		--目标地点播放图标渐隐效果
		if self.playIdx>#self.data.grids then
			EventMgr.Dispatch(EventType.RichMan_GridIcon_Alpha,{pos=self.currGrid:GetPos(),isHide=true})
		end
    end
	if self:GetState()==1 then
		local nextPos = pos + self.moveDirection * Time.deltaTime*self.speed;
		local toTarget = self.targetPos - nextPos;
		-- local dist = dir.magnitude;
		local dist=UnityEngine.Vector3.Dot(self.moveDirection,toTarget);
		-- LogError(tostring(dist) .. "\t" .. tostring(self.done))
		-- LogError(self.step.."\t"..tostring(self.data.step).."\t"..tostring(dist))
		if dist < 0.05 then
			playerCtrl.gameObject.transform.position = self.targetPos;
			if self.playIdx>#self.data.grids then
				local gridInfo=self.data.mapData:GetNextGridBySort(self.currGrid:GetSort());
				local nGO=playerCtrl.GetGridGO(gridInfo:GetPos());
				playerCtrl.LookAt(nGO);
				playerCtrl.PlayMove(false);
				self:SetState(2);
				EventMgr.Dispatch(EventType.RichMan_Set_TargetEff,{grids=self.data.grids,isShow=false})
			else
				--播放图标渐显效果
				-- EventMgr.Dispatch(EventType.RichMan_GridIcon_Alpha,{pos=self.currGrid:GetPos(),isHide=false,isNum=true})
				self.targetPos=nil;
			end
		else
			if self.targetGO ~= nil then
				-- 设置旋转角度
				playerCtrl.LookAt(self.targetGO);
			end
			playerCtrl.gameObject.transform.position = nextPos
		end
	elseif self:GetState()==2 and self.sendPress~=true then
		if self.targetGrid ~= nil then
			-- 播放触发动效
			self.targetGrid.PlayPressEff(function()
				self:SetState(3);
			end);
		else
			self:SetState(3);
			LogError("未找到格子特效信息，跳过触发特效播放");
		end
		self.sendPress=true
	elseif self:GetState()==3 then
		self.done = true;
		EventMgr.Dispatch(EventType.RichMan_MoveAction_State,false)
	end
end

return this;

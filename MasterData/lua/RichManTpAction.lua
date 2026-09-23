local this = oo.class(RichManActionBase)

-- 大富翁传送事件
function this:Enter(playerCtrl)
    self:SetState(1);
    self.playState=1;
end

function this:Update(playerCtrl)
    if RichManActionBase:Update(playerCtrl) then
        do
            return
        end
    end
    -- 播放传送特效
    if self:GetState() == 1 and self.playState==1 then
		if self.data and self.data.gridInfo:GetValue1() ~= nil then
            local _,ctrl=playerCtrl.GetGridGO(self.data.gridInfo:GetPos());
            ctrl.PlayTPEff(true);
            playerCtrl.PlayTP(true,function()
                ctrl.PlayIconAlpha(false);
                self:SetState(2);
            end);
        else
	        self:SetState(2);
		end
        self.playState=2;
    end
	
    if self:GetState() == 2 and self.playState==2 then
        -- 如果存在位置则传送到指定位置
        if self.data and self.data.gridInfo:GetValue1() ~= nil then
            local mapData = RichManMgr:GetMapInfo(self.data.gridInfo:GetTempID());
            if mapData ~= nil then
				-- LogError("传送到ID为："..tostring(self.data.gridInfo:GetValue1()[1]).."的格子");
                local grid = mapData:GetGridInfoByID(self.data.gridInfo:GetValue1()[1]);
                if grid == nil then
                    LogError("地图：" .. self.data.gridInfo:GetTempID() .. "中未找到对应ID的格子信息！id=" ..
                                 tostring(self.data.gridInfo:GetValue1()[1]));
                    self.done = true;
                    do
                        return
                    end
                end
                local go,ctrl2 = playerCtrl.GetGridGO(grid:GetPos());
                playerCtrl.SetPos(go.position.x, 0, go.position.z);
                local nextPos = mapData:GetNextGridBySort(grid:GetSort());
                if nextPos then
                    -- 设置旋转角度为面向下一步的方向
                    playerCtrl.LookAt(playerCtrl.GetGridGO(nextPos:GetPos()));
                end
                ctrl2.PlayIconAlpha(true);
                ctrl2.PlayTPEff(false);
                playerCtrl.PlayTP(false,function()
                    self:SetState(3);
                end);
            else
                self:SetState(3);
            end
        else
            self:SetState(3);
        end
        self.playState=3;
    end

    self.done = self:GetState() == 3;
end

return this;

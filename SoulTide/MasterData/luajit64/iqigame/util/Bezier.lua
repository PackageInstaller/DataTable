-- chunkname: @IQIGame\\Util\\Bezier.lua

Bezier = {}

function Bezier.New(tp0, tp1, tp2)
	local cls = Clone(Bezier)

	cls:Init(tp0, tp1, tp2)

	return cls
end

function Bezier:s(t)
	return math.sqrt(self.A * t * t + self.B * t + self.C)
end

function Bezier:L(t)
	local temp1 = math.sqrt(self.C + t * (self.B + self.A * t))
	local temp2 = 2 * self.A * t * temp1 + self.B * (temp1 - math.sqrt(self.C))
	local temp3 = math.log(self.B + 2 * math.sqrt(self.A) * math.sqrt(self.C))
	local temp4 = math.log(self.B + 2 * self.A * t + 2 * math.sqrt(self.A) * temp1)
	local temp5 = 2 * math.sqrt(self.A) * temp2
	local temp6 = (self.B * self.B - 4 * self.A * self.C) * (temp3 - temp4)

	return (temp5 + temp6) / (8 * math.pow(self.A, 1.5))
end

function Bezier:InvertL(t, l)
	local t1 = t
	local t2

	while true do
		t2 = t1 - (self:L(t1) - l) / self:s(t1)

		if math.abs(t1 - t2) < 1e-06 then
			break
		end

		t1 = t2
	end

	return t2
end

function Bezier:Init(tp0, tp1, tp2)
	self.p0 = tp0
	self.p1 = tp1
	self.p2 = tp2
	self.ax = self.p0.x - 2 * self.p1.x + self.p2.x
	self.ay = self.p0.y - 2 * self.p1.y + self.p2.y
	self.bx = 2 * self.p1.x - 2 * self.p0.x
	self.by = 2 * self.p1.y - 2 * self.p0.y
	self.A = 4 * (self.ax * self.ax + self.ay * self.ay)
	self.B = 4 * (self.ax * self.bx + self.ay * self.by)
	self.C = self.bx * self.bx + self.by * self.by
	self.total_length = self:L(1)

	local tspeed = 0.3

	self.step = math.floor(self.total_length / tspeed)

	if self.total_length % tspeed > tspeed / 2 then
		self.step = self.step + 1
	end

	return self.step
end

function Bezier:GetPointAtTime(t)
	local l = t * self.total_length

	t = self:InvertL(t, l)

	local xx = (1 - t) * (1 - t) * self.p0.x + 2 * (1 - t) * t * self.p1.x + t * t * self.p2.x
	local yy = (1 - t) * (1 - t) * self.p0.y + 2 * (1 - t) * t * self.p1.y + t * t * self.p2.y
	local Q0 = Vector2((1 - t) * self.p0.x + t * self.p1.x, (1 - t) * self.p0.y + t * self.p1.y)
	local Q1 = Vector2((1 - t) * self.p1.x + t * self.p2.x, (1 - t) * self.p1.y + t * self.p2.y)
	local dx = Q1.x - Q0.x
	local dy = Q1.y - Q0.y
	local radians = math.atan2(dy, dx)
	local degrees = radians * 180 / math.pi

	return xx, yy, degrees
end

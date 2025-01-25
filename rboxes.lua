local rBoxes = {}

do
	local mat = Material('rboxes/simple')
	local mat2 = Material('rboxes/mask')

	local setFloat = mat.SetFloat
	local setDrawColor = surface.SetDrawColor
	local setMaterial = surface.SetMaterial
	local drawTexturedRectUV = surface.DrawTexturedRectUV

	---@param radius number
  ---@param x integer
  ---@param y integer
  ---@param w integer
  ---@param h integer
  ---@param color Color
	function rBoxes.drawRoundedBox(radius, x, y, w, h, color)
		setFloat(mat, '$c0_x', w)
		setFloat(mat, '$c0_y', h)
		setFloat(mat, '$c0_z', radius / w * 2)
		setFloat(mat, '$c0_w', radius / h * 2)

		setDrawColor(color)
		setMaterial(mat)

		drawTexturedRectUV(x, y, w, h, -0.015625, -0.015625, 1.015625, 1.015625)
	end

	local setTexture = mat.SetTexture

	---@param radius number
  ---@param x integer
  ---@param y integer
  ---@param w integer
  ---@param h integer
  ---@param color Color
  ---@param texture ITexture
	function rBoxes.drawRoundedBoxTextured(radius, x, y, w, h, color, texture)
		setFloat(mat2, '$c0_x', w)
		setFloat(mat2, '$c0_y', h)
		setFloat(mat2, '$c0_z', radius / w)
		setFloat(mat2, '$c0_w', radius / h)
		setTexture(mat2, '$basetexture', texture)

		setDrawColor(color)
		setMaterial(mat2)

		drawTexturedRectUV(x, y, w, h, -0.015625, -0.015625, 1.015625, 1.015625)
	end
end

return rBoxes

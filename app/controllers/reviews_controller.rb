class ReviewsController < ApplicationController
  before_action :set_product

  def create
    @review = @product.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @product, notice: "Avaliação adicionada com sucesso!"
    else
      redirect_to @product, alert: "Erro ao salvar avaliação."
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def review_params
    params.expect(review: [ :rating, :comment ])
  end
end

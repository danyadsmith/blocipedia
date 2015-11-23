class ChargesPolicy < Struct.new(:user, :charges)

  def index?
    true
  end

  def new?
    true
  end

  def show?
    return true if user.present?
  end

  def create?
    return true if user.present?
  end

  def edit?
    true
  end

  def update?
    return true if user.present?
  end

  def destroy?
    return true if user.present?
  end

  private

  def charges
    record
  end

end
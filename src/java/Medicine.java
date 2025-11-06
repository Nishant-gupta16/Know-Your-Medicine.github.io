import java.util.Objects;

public class Medicine {
    private String name;
    private String description;
    private String dosage;
    private String sideEffects;
    private String benefits;
    private double price;

    // Constructor
    public Medicine(String name, String description, String dosage, String sideEffects, String benefits, double price) {
        if (price < 0) {
            throw new IllegalArgumentException("Price cannot be negative.");
        }
        this.name = name;
        this.description = description;
        this.dosage = dosage;
        this.sideEffects = sideEffects;
        this.benefits = benefits;
        this.price = price;
    }

    // Getters
    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public String getDosage() {
        return dosage;
    }

    public String getSideEffects() {
        return sideEffects;
    }

    public String getBenefits() {
        return benefits;
    }

    public double getPrice() {
        return price;
    }

    // Optional Setters
    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setDosage(String dosage) {
        this.dosage = dosage;
    }

    public void setSideEffects(String sideEffects) {
        this.sideEffects = sideEffects;
    }

    public void setBenefits(String benefits) {
        this.benefits = benefits;
    }

    public void setPrice(double price) {
        if (price < 0) {
            throw new IllegalArgumentException("Price cannot be negative.");
        }
        this.price = price;
    }

    // toString Method
    @Override
    public String toString() {
        return "Medicine{" +
                "name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", dosage='" + dosage + '\'' +
                ", sideEffects='" + sideEffects + '\'' +
                ", benefits='" + benefits + '\'' +
                ", price=" + price +
                '}';
    }

    // equals and hashCode (Optional)
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Medicine medicine = (Medicine) obj;
        return Double.compare(medicine.price, price) == 0 &&
                name.equals(medicine.name) &&
                description.equals(medicine.description);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, description, price);
    }
}
